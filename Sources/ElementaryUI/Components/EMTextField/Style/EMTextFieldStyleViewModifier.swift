//
//  EMTextFieldStyleViewModifier.swift
//
//
//  Created by Joe Maghzal on 02/05/2024.
//

import SwiftUI

extension EnvironmentValues {
// TODO: - Remove `canImport(SwiftUICore)` when Xcode 16 comes out of beta.
#if canImport(SwiftUICore)
    /// The current text field style set in the environment.
    @Entry internal var emTextFieldStyle: (any EMTextFieldStyle) = .default
#else
    /// The current text field style set in the environment.
    @EnvironmentValue internal var emTextFieldStyle: (any EMTextFieldStyle) = .default
#endif
}

extension View {
    /// Sets the text field style for the view hierarchy.
    ///
    /// Use this modifier to apply a specific style to all ``EMTextField`` 
    /// views within the hierarchy below the modified view.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             EMTextField("Username", text: $username)
    ///             EMTextField("Password", text: $password)
    ///         }.emTextFieldStyle(MyCustomTextFieldStyle())
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///  - style: The style to apply to all text fields within the hierarchy.
    ///  - override: Wether to override the existing styles, or aggregate
    ///  them with the new style.
    ///
    /// - Returns: A view modified to use the specified text field style.
    @ViewBuilder public func emTextFieldStyle<Style: EMTextFieldStyle>(
        _ style: Style,
        override: Bool = false
    ) -> some View {
            // TODO: - Remove `swift(>=5.10)` when Xcode 16 comes out of beta.
#if swift(>=5.10)
        if override {
            environment(\.emTextFieldStyle, style)
        }else {
            modifier(EMTextField.StyleViewModifier(style: style))
        }
#else
        environment(\.emTextFieldStyle, style)
#endif
    }
}
