//
//  EMButtonStyle.swift
//
//
//  Created by Joe Maghzal on 03/08/2024.
//

import SwiftUI

@Stylable(
    environmentKey: "emButtonStyle",
    configurations: EMButtonStyleConfiguration.self,
    accessLevel: .public
)
fileprivate enum EMButton { }

/// The properties of a button.
public struct EMButtonStyleConfiguration {
    /// An optional semantic role that describes the button's purpose.
    ///
    /// A value of `nil` means that the Button doesn't have an assigned role. If
    /// the button does have a role, use it to make adjustments to the button's
    /// appearance. The following example shows a custom style that uses
    /// bold text when the role is ``ButtonRole/cancel``,
    /// ``ShapeStyle/red`` text when the role is ``ButtonRole/destructive``,
    /// and adds no special styling otherwise:
    ///
    ///     struct MyButtonStyle: ButtonStyle {
    ///         func makeBody(configuration: Configuration) -> some View {
    ///             configuration.label
    ///                 .font(
    ///                     configuration.role == .cancel ? .title2.bold() : .title2)
    ///                 .foregroundColor(
    ///                     configuration.role == .destructive ? Color.red : nil)
    ///         }
    ///     }
    ///
    /// You can create one of each button using this style to see the effect:
    ///
    ///     VStack(spacing: 20) {
    ///         Button("Cancel", role: .cancel) {}
    ///         Button("Delete", role: .destructive) {}
    ///         Button("Continue") {}
    ///     }
    ///     .buttonStyle(MyButtonStyle())
    ///
    /// ![A screenshot of three buttons stacked vertically. The first says
    /// Cancel in black, bold letters. The second says Delete in red, regular
    /// weight letters. The third says Continue in black, regular weight
    /// letters.](ButtonStyleConfiguration-role-1)
    public var role: ButtonRole?
    
    /// A Boolean that indicates whether the user is currently pressing the
    /// button.
    public var isPressed: Bool
}

extension EnvironmentValues {
    // TODO: - Remove `canImport(SwiftUICore)` when Xcode 16 comes out of beta.
#if canImport(SwiftUICore)
    /// The current button style set in the environment.
    @Entry internal var emButtonStyle: (any EMButtonStyle) = .default
#else
    /// The current button style set in the environment.
    @EnvironmentValue internal var emButtonStyle: (any EMButtonStyle) = .default
#endif
}

extension View {
    /// Sets the button style style for the view hierarchy.
    ///
    /// Use this modifier to apply a specific style to all ``Button`` 
    /// views within the hierarchy below the modified view.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             Button(action: {
    ///             }) {
    ///                 Text("My Button")
    ///             }
    ///             Button(action: {
    ///             }) {
    ///                 Text("My Second Button")
    ///             }
    ///         }.emButtonStyle(MyCustomButtonStyle())
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///  - style: The style to apply to all text fields within the hierarchy.
    ///  - override: Wether to override the existing styles, or aggregate
    ///  them with the new style.
    ///
    /// - Returns: A view modified to use the specified button style.
    ///
    /// - Warning: You must set the vanilla button style to 
    /// ``EMButtonStyleWrapper``
    /// up the hierarchy, preferably in your ``App`` struct.
    @ViewBuilder public func emButtonStyle<S: EMButtonStyle>(
        _ style: S,
        override: Bool = false
    ) -> some View {
            // TODO: - Remove `swift(>=5.10)` when Xcode 16 comes out of beta.
#if swift(>=5.10)
        if override {
            environment(\.emButtonStyle, style)
        }else {
            modifier(EMButton.StyleViewModifier(style: style))
        }
#else
        environment(\.emButtonStyle, style)
#endif
    }
}
