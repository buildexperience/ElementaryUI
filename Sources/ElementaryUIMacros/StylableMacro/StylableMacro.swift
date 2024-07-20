//
//  StylableMacro.swift
//  
//
//  Created by Joe Maghzal on 29/06/2024.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import MacrosKit

/// A macro that provides automatic style management & aggregation for views.
///
/// This macro facilitates the application of styles to views by automatically
/// generating necessary modifiers & aggregating multiple styles into one.
/// It also supports custom environment keys for style management.
///
/// **Example Usage:**
/// ```swift
/// @Stylable(
///     environmentKey: "contentViewStyle",
///     style: "ContentViewStyle",
///     configurations: ContentViewConfiguration.self
/// )
/// public struct ContentView: View {
///     public var body: some View {
///         Text("Styled Text")
///     }
/// }
/// ```
///
/// **Expanded:**
/// ```swift
/// public struct ContentView: View {
///     var body: some View {
///         Text("Styled Text")
///     }
/// }
///
/// public protocol ContentViewStyle: ViewStyle where Configuration == ContentConfiguration {
/// }
///
/// extension ContentView {
///     internal struct StyleViewModifier<Style: ContentViewStyle>: ViewModifier {
///         @Environment(\.contentViewStyle) private var currentStyle
///         private let style: Style
///         private var newStyle: any ContentViewStyle {
///             return AggregatedStyle(currentStyle: currentStyle, style: style)
///         }
///
///         internal init(style: Style) {
///             self.style = style
///         }
///
///         internal func body(content: Content) -> some View {
///             content
///                 .environment(\.contentViewStyle, newStyle)
///         }
///     }
/// }
///
/// extension ContentView {
///     fileprivate struct AggregatedStyle<Style: ContentViewStyle>: ContentViewStyle {
///         private let currentStyle: any ContentViewStyle
///         private let style: Style
///
///         fileprivate init(currentStyle: any ContentViewStyle, style: Style) {
///             self.currentStyle = currentStyle
///             self.style = style
///         }
///
///         fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
///             let newContent = currentStyle.makeBody(
///                 content: content,
///                 configuration: configuration
///             )
///
///             VStack {
///                 AnyView(style.makeBody(
///                     content: AnyView(newContent),
///                     configuration: configuration)
///                 )
///             }
///         }
///     }
/// }
/// ```
///
/// - Parameters:
///   - environmentKey: The name of the environment key used to store
///     & retrieve the style.
///   - style: The name of the style protocol. Defaults to the name
///   of the view suffixed with "Style".
///   - configurations: The type that represents the configurations for the
///     style. Defaults to the name of the view suffixed with "Configuration".
///
/// - Warning: You need to implement the environment value, configuration
/// & default style manually.
package enum StylableMacro {
    private static func verifyConformance(
        declaration: some DeclSyntaxProtocol,
        node: AttributeSyntax,
        viewName: TokenSyntax
    ) throws {
        let inheritedTypes = declaration.inheritedTypes
        let hasViewConformance = inheritedTypes?.contains { inherited in
            let name = inherited.type.as(IdentifierTypeSyntax.self)?.name
            return name?.text == "View"
        }
        guard hasViewConformance != true else {return}
        
        let error = StylableMacroError.missingViewConformance(name: viewName.text)
        throw error
    }
}

//MARK: - PeerMacro
extension StylableMacro: PeerMacro {
    /// Generates the style protocol for a view.
    package static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let viewName = declaration.typeName else {
            throw StylableMacroError.invalidDeclaration
        }
        try verifyConformance(
            declaration: declaration,
            node: node,
            viewName: viewName
        )
                
        let accessLevel = declaration.accessLevel?.modifier
        let arguments = node.arguments?.arguments
        let factory = Argument.Factory(arguments: arguments)
        let styleProtocol = factory.argument(
            key: .styleProtocol,
            defaultValue: "\(viewName)Style"
        )
        let configurations = factory.argument(
            key: .configurations,
            defaultValue: "\(viewName)Configuration"
        )
        
        let declarationFactory = DeclarationsFactory(styleProtocol: styleProtocol)
        
        return [
            declarationFactory.styleProtocol(
                configurations: configurations,
                accessLevel: accessLevel
            )
        ]
    }
}

//MARK: - ExtensionMacro
extension StylableMacro: ExtensionMacro {
    /// Generates the style view modifier & aggregated style for a styled view.
    package static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard let viewName = declaration.typeName else {
            throw NSError()
        }
        try verifyConformance(
            declaration: declaration,
            node: node,
            viewName: viewName
        )
        
        let arguments = node.arguments?.arguments
        let factory = Argument.Factory(arguments: arguments)
        let styleProtocol = factory.argument(
            key: .styleProtocol,
            defaultValue: "\(viewName)Style"
        )
        let environmentKey = factory.argument(
            key: .environmentKey,
            defaultValue: styleProtocol.lowerCasedPrefix
        )
        
        let declarationFactory = DeclarationsFactory(styleProtocol: styleProtocol)
        let aggregatedDeclaration = declarationFactory.aggregatedStyle(
            type: type
        )
        let modifierDeclaration = declarationFactory.modifier(
            type: type,
            environmentKey: environmentKey
        )
        
        guard let modifier = modifierDeclaration.as(ExtensionDeclSyntax.self),
              let aggregated = aggregatedDeclaration.as(ExtensionDeclSyntax.self)
        else {
            return []
        }
        
        return [modifier, aggregated]
    }
}
