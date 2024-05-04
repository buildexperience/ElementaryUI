//
//  DefaultEMTextFieldStyle.swift
//
//
//  Created by Joe Maghzal on 20/04/2024.
//

import SwiftUI

/// The default style for ``EMTextField``.
public struct DefaultEMTextFieldStyle: EMTextFieldStyle {
    /// Creates a default text field style.
    public init() { }
    
    /// Creates a view that represents the body of a text field.
    ///
    /// The system calls this method for each ``EMTextField`` instance in a view hierarchy where this style is the current text field style.
    ///
    /// - Parameter configuration : The properties of the text field.
    /// - Returns: A view that represents the body of a text field.
    ///
    public func makeBody(configuration: Configuration) -> some View {
        configuration.content
    }
}

public extension EMTextFieldStyle where Self == DefaultEMTextFieldStyle {
    /// The default style for ``EMTextField``.
    static var `default`: DefaultEMTextFieldStyle {
        return DefaultEMTextFieldStyle()
    }
}
