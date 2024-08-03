//
//  StylableMacroDeclarationFactory.swift
//
//
//  Created by Joe Maghzal on 29/06/2024.
//

import SwiftSyntax

extension StylableMacro {
    /// Factory for creating declarations for the ``StylableMacro``.
    internal struct DeclarationsFactory {
        /// The style protocol name.
        internal let styleProtocol: TokenSyntax
    }
}

// MARK: - Functions
extension StylableMacro.DeclarationsFactory {
    /// Creates a protocol declaration for the style protocol.
    ///
    /// - Parameters:
    ///   - configurations: The token syntax representing the configurations name.
    ///   - accessLevel: The token syntax representing the access level (e.g., `public`, `internal`).
    ///
    /// - Returns: A ``DeclSyntax`` representing the protocol declaration.
    internal func styleProtocol(
        configurations: TokenSyntax,
        accessLevel: TokenSyntax?
    ) -> DeclSyntax {
        return """
        \(accessLevel)protocol \(styleProtocol): ViewStyle where Configuration == \(configurations) {
            typealias Configuration = \(configurations)
        }
        """
    }
    
    /// Creates a struct declaration for the aggregated style.
    ///
    /// - Parameter type: The type to extend.
    ///
    /// - Returns: A ``DeclSyntax`` representing the struct declaration for the aggregated style.
    internal func aggregatedStyle(
        type: TypeSyntaxProtocol
    ) -> DeclSyntax {
        let declaration: DeclSyntax = """
        fileprivate struct AggregatedStyle<Style: \(styleProtocol)>: \(styleProtocol) {
            private let currentStyle: any \(styleProtocol)
            private let style: Style
        
            fileprivate init(currentStyle: any \(styleProtocol), style: Style) {
                self.currentStyle = currentStyle
                self.style = style
            }
        
            fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                let newContent = style.makeBody(
                    content: content,
                    configuration: configuration
                )
        
                VStack {
                    AnyView(currentStyle.makeBody(
                        content: AnyView(newContent),
                        configuration: configuration)
                    )
                }
            }
        }
        """
        
        return makeWithExtension(type: type, declaration: declaration)
    }
    
    /// Creates a struct declaration for the style view modifier.
    ///
    /// - Parameters:
    ///   - type: The type to extend.
    ///   - environmentKey: The token syntax representing the environment key name.
    ///   
    /// - Returns: A ``DeclSyntax`` representing the struct declaration for the style view modifier.
    internal func modifier(
        type: TypeSyntaxProtocol,
        environmentKey: TokenSyntax
    ) -> DeclSyntax {
        let declaration: DeclSyntax = """
        internal struct StyleViewModifier<Style: \(styleProtocol)>: ViewModifier {
            @Environment(\\.\(environmentKey)) private var currentStyle
            private let style: Style
            private var newStyle: any \(styleProtocol) {
                return AggregatedStyle(currentStyle: currentStyle, style: style)
            }
        
            internal init(style: Style) {
                self.style = style
            }
        
            internal func body(content: Content) -> some View {
                content
                    .environment(\\.\(environmentKey), newStyle)
            }
        }
        """
        
        return makeWithExtension(type: type, declaration: declaration)
    }
    
    /// Wraps the given declaration in an extension for the specified type.
    ///
    /// - Parameters:
    ///   - type: The type to extend.
    ///   - declaration: The declaration to be wrapped.
    ///
    /// - Returns: A ``DeclSyntax`` representing the extension with the wrapped declaration.
    internal func makeWithExtension(
        type: TypeSyntaxProtocol,
        declaration: DeclSyntax
    ) -> DeclSyntax {
        return """
        extension \(type) {
            \(declaration)
        }
        """
    }
}
