//
//  StyledTextFieldPromptViewModifier.swift
//
//
//  Created by Joe Maghzal on 29/07/2024.
//

import SwiftUI

/// View modifier that allows customization of text field prompts using a provided style.
///
/// This view modifier enables the styling of text field prompts by applying a specified style
/// to the prompt text. It uses the ``promptStyle`` environment value to access and modify the
/// style of the prompt.
///
/// - Warning: This is an internal modifier not meant to be used directly.
///  You should use ``prompt(_:)`` instead.
fileprivate struct StyledTextFieldPromptViewModifier: ViewModifier {
    /// The current style for the prompt.
    @Environment(\.promptStyle) private var promptStyle
    
    /// The ``Text`` builder to style the prompt.
    fileprivate let promptBuilder: (_ text: Text) -> Text
    
    /// The new prompt style to use.
    private var newPromptStyle: (_ text: Text) -> Text {
        return { text in
            let prompt = promptStyle?(text) ?? text
            return promptBuilder(prompt)
        }
    }
    
    /// The body of the ``ViewModifier``.
    fileprivate func body(content: Content) -> some View {
        content
            .environment(\.promptStyle, newPromptStyle)
    }
}

extension EnvironmentValues {
// TODO: - Remove `canImport(SwiftUICore)` when Xcode 16 comes out of beta.
#if canImport(SwiftUICore)
    /// Key for accessing the ``promptStyle`` environment value.
    @Entry internal var promptStyle: ((_ text: Text) -> Text)? = nil
#else
    /// Key for accessing the ``promptStyle`` environment value.
    @EnvironmentValue internal var promptStyle: ((_ text: Text) -> Text)? = nil
#endif
}

// MARK: - Modifiers
extension View {
    /// Applies a custom prompt style to the view.
    ///
    /// - Parameter builder: A closure that takes a ``Text``
    ///  view and returns a modified ``Text`` view.
    ///
    /// - Returns: A view with the applied custom prompt style.
    public func prompt(
        _ builder: @escaping (_ text: Text) -> Text
    ) -> some View {
        modifier(StyledTextFieldPromptViewModifier(promptBuilder: builder))
    }
    
    /// Applies a foreground style to the prompt text.
    ///
    /// - Parameter style: The shape style to apply to the prompt text.
    ///
    /// - Returns: A view modified to use the specified foreground style for prompts.
    @available(iOS 17.0, macOS 14.0, watchOS 10.0, tvOS 15.0, visionOS 1.0, *)
    @inlinable public func promptForegroundStyle<S: ShapeStyle>(
        _ style: S
    ) -> some View {
        prompt({$0.foregroundStyle(style)})
    }
    
    /// Applies a font to the prompt text.
    ///
    /// - Parameter font: The font to apply to the prompt text.
    ///
    /// - Returns: A view modified to use the specified font for prompts.
    @inlinable public func promptFont(_ font: Font) -> some View {
        prompt({$0.font(font)})
    }
    
    /// Applies a foreground color to the prompt text.
    ///
    /// - Parameter color: The color to apply to the prompt text.
    ///
    /// - Returns: A view modified to use the specified foreground color for prompts.
    ///
    /// - Warning: This method is deprecated in favor of `promptForegroundStyle(_:)`.
    @available(iOS, deprecated: 17.0, renamed: "promptForegroundStyle(_:)")
    @available(macOS, deprecated: 14.0, renamed: "promptForegroundStyle(_:)")
    @available(watchOS, deprecated: 10.0, renamed: "promptForegroundStyle(_:)")
    @available(tvOS, deprecated: 15.0, renamed: "promptForegroundStyle(_:)")
    @available(visionOS, deprecated: 1.0, renamed: "promptForegroundStyle(_:)")
    @inlinable public func promptForegroundColor(_ color: Color) -> some View {
        prompt({$0.foregroundColor(color)})
    }
}
