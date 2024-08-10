//
//  DefaultEMButtonStyle.swift
//  
//
//  Created by Joe Maghzal on 10/08/2024.
//

import SwiftUI

/// The default style for ``Button`` when ``EMButtonStyleWrapper``
/// is applied.
public struct DefaultEMButtonStyle: EMButtonStyle {
    /// Creates a default button style.
    public init() { }
    
    /// Creates a view that represents the styled body of a button.
    ///
    /// The system calls this method for each ``Button`` instance
    /// in a view hierarchy where this style is the current button style
    /// & ``EMButtonStyleWrapper`` is applied.
    ///
    /// - Parameters:
    ///   - content : The content of the button.
    ///   - configuration : The properties of the button.
    ///
    /// - Returns: The styled styled body of the button.
    public func makeBody(
        content: Content,
        configuration: Configuration
    ) -> some View {
        content
    }
}

extension EMButtonStyle where Self == DefaultEMButtonStyle {
    /// The default style for ``Button`` when ``EMButtonStyleWrapper``
    ///  is applied.
    public static var `default`: DefaultEMButtonStyle {
        return DefaultEMButtonStyle()
    }
}
