//
//  SimplePromptStyle.swift
//
//
//  Created by Joe Maghzal on 10/08/2024.
//

import SwiftUI

/// Simple ``PromptStyle`` that styles the prompt ``Text`` using a closure.
fileprivate struct SimplePromptStyle: PromptStyle {
    /// Closure that takes a ``Text`` view 
    /// & returns a modified ``Text`` view.
    fileprivate let builder: @Sendable (_ text: Text) -> Text
    
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
        builder(content)
    }
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
        _ builder: @Sendable @escaping (_ text: Text) -> Text
    ) -> some View {
        promptStyle(SimplePromptStyle(builder: builder))
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
    @available(iOS, deprecated: 17.0, renamed: "promptForegroundStyle")
    @available(macOS, deprecated: 14.0, renamed: "promptForegroundStyle")
    @available(watchOS, deprecated: 10.0, renamed: "promptForegroundStyle")
    @available(tvOS, deprecated: 15.0, renamed: "promptForegroundStyle")
    @available(visionOS, deprecated: 1.0, renamed: "promptForegroundStyle")
    @inlinable public func promptForegroundColor(_ color: Color) -> some View {
        prompt({$0.foregroundColor(color)})
    }
}
