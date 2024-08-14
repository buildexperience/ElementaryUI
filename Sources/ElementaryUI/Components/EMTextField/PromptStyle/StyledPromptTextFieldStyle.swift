//
//  StyledTextFieldPromptViewModifier.swift
//
//
//  Created by Joe Maghzal on 29/07/2024.
//

import SwiftUI

public protocol PromptStyle: DynamicProperty, Sendable {
    /// Creates a view that represents the styled body of a prompt.
    ///
    /// The system calls this method for each prompt ``Text`` instance
    /// in a view hierarchy where this style is the current prompt style.
    ///
    /// - Parameters:
    ///  - content : The prompt ``Text``.
    ///
    /// - Returns: The styled body of the prompt.
    @MainActor func makeBody(content: Text) -> Text
}

/// ``PromptStyle`` for aggregating multiple styles into one.
fileprivate struct AggregatedPromptStyle: PromptStyle {
    /// The currently applied style.
    fileprivate let currentStyle: any PromptStyle
    
    /// The new style to combine with the current.
    fileprivate let style: any PromptStyle
    
    /// Creates a view that represents the styled body of a prompt.
    ///
    /// The system calls this method for each prompt ``Text`` instance
    /// in a view hierarchy where this style is the current prompt style.
    ///
    /// - Parameters:
    ///  - content : The prompt ``Text``.
    ///
    /// - Returns: The styled body of the prompt.
    fileprivate func makeBody(content: Text) -> Text {
        let newText = style.makeBody(content: content)
        return currentStyle.makeBody(content: newText)
    }
}

/// View modifier that allows customization of text field prompts using a provided style.
///
/// This view modifier enables the styling of text field prompts by applying a specified style
/// to the prompt text. It uses the ``promptStyle`` environment value to access and modify the
/// style of the prompt.
///
/// - Warning: This is an internal modifier not meant to be used directly.
///  You should use ``prompt(_:)`` instead.
fileprivate struct PromptStyleViewModifier: ViewModifier {
    /// The current prompt style.
    @Environment(\.promptStyle) private var currentStyle
    
    /// The promt style to combine with the current one.
    fileprivate let style: any PromptStyle
    
    /// The new prompt style to use.
    private var newStyle: any PromptStyle {
        return AggregatedPromptStyle(currentStyle: currentStyle, style: style)
    }
    
    /// The body of the ``ViewModifier``.
    fileprivate func body(content: Content) -> some View {
        content
            .environment(\.promptStyle, newStyle)
    }
}

extension EnvironmentValues {
#if canImport(SwiftUICore)
    /// Key for accessing the ``promptStyle`` environment value.
    @Entry internal var promptStyle: any PromptStyle = .default
#else
    /// Key for accessing the ``promptStyle`` environment value.
    @EnvironmentValue internal var promptStyle: any PromptStyle = DefaultPromptStyle()
#endif
}

extension View {
    /// Sets the prompt style for the view hierarchy.
    ///
    /// Use this modifier to apply a specific style to all prompt ``Text`` 
    /// views within the hierarchy below the modified view.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             EMTextField("Username", text: $username)
    ///             EMTextField("Password", text: $password)
    ///         }.promptStyle(MyCustomPromptStyle())
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///  - style: The style to apply to all prompts within the hierarchy.
    ///  - override: Wether to override the existing styles, or aggregate
    ///  them with the new style.
    ///
    /// - Returns: A view modified to use the specified prompt style.
    @ViewBuilder public func promptStyle<Style: PromptStyle>(
        _ style: Style,
        override: Bool = false
    ) -> some View {
        if override {
            environment(\.promptStyle, style)
        }else {
            modifier(PromptStyleViewModifier(style: style))
        }
    }
}
