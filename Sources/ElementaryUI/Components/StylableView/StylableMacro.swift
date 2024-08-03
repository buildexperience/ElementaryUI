//
//  StylableMacro2.swift
//
//
//  Created by Joe Maghzal on 29/06/2024.
//

import SwiftUI

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
@attached(
    extension,
    names: named(StyleViewModifier),
    named(AggregatedStyle),
    suffixed(Style)
)
@attached(peer, names: suffixed(Style))
public macro Stylable(
    environmentKey: String = "",
    style: String = "",
    configurations: Any.Type = Never.self,
    accessLevel: MacroAccessLevel = .internal
) = #externalMacro(
    module: "ElementaryUIMacros",
    type: "StylableMacro"
)

public enum MacroAccessLevel {
    /// Public access level.
    case `public`
    
    /// Package private access level.
    case `package`
    
    /// Internal access level.
    case `internal`
    
    /// Private access level.
    case `private`
    
    /// Fileprivate access level.
    case `fileprivate`
    
    /// Open access level.
    case `open`
}
