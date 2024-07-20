//
//  EMTextFieldStyleViewModifier.swift
//
//
//  Created by Joe Maghzal on 02/05/2024.
//

import SwiftUI

extension EnvironmentValues {
    /// The current text field style set in the environment.
#if canImport(SwiftUICore)
    @Entry internal var emTextFieldStyle: (any EMTextFieldStyle) = DefaultEMTextFieldStyle()
#else
    @EnvironmentValue internal var emTextFieldStyle: (any EMTextFieldStyle) = DefaultEMTextFieldStyle()
#endif
}

extension View {
    /// Sets the text field style for the view hierarchy.
    ///
    /// Use this modifier to apply a specific style to all ``EMTextField`` views within the hierarchy below the modified view.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             EMTextField("Username", text: $username)
    ///                 .emTextFieldStyle(MyCustomTextFieldStyle())
    ///             EMTextField("Password", text: $password)
    ///                 .emTextFieldStyle(MyCustomTextFieldStyle())
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter style: The style to apply to all text fields within the hierarchy.
    /// 
    /// - Returns: A view modified to use the specified text field style.
    public func emTextFieldStyle<Style: EMTextFieldStyle>(_ style: Style) -> some View {
        modifier(EMTextField.StyleViewModifier(style: style))
    }
}
