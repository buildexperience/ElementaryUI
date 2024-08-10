//
//  DefaultPromptStyle.swift
//
//
//  Created by Joe Maghzal on 10/08/2024.
//

import SwiftUI

/// Identifier indicating that a ``PromptStyle`` should not be applied.
internal protocol EmptyPromptStyle: PromptStyle { }

/// The default style for ``PromptStyle``.
public struct DefaultPromptStyle: PromptStyle, EmptyPromptStyle {
    /// Creates a default prompt style.
    public init() { }
    
    /// Creates a view that represents the styled body of a prompt.
    ///
    /// The system calls this method for each prompt ``Text`` instance
    /// in a view hierarchy where this style is the current prompt style.
    ///
    /// - Parameter content : The prompt ``Text``.
    ///
    /// - Returns: The styled body of the prompt.
    public func makeBody(content: Text) -> Text {
        content
    }
}

extension PromptStyle where Self == DefaultPromptStyle {
    /// The default style for ``PromptStyle``.
    public static var `default`: DefaultPromptStyle {
        return DefaultPromptStyle()
    }
}
