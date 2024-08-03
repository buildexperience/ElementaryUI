//
//  EMButtonStyleWrapper.swift
//  
//
//  Created by Joe Maghzal on 03/08/2024.
//

import SwiftUI

/// Wrapper ``ButtonStyle`` that wraps ``EMButtonStyle`` &
/// applies them to all buttons in the hierarchy without the need to use
/// a custom ``EMButton`` view instead of the built-in ``Button``.
///
/// ``EMButtonStyle`` differs from ``ButtonStyle`` in it's ability
/// to be chained with other styles.
///
/// Apply this button style at the top of your view hierarchy & start using
/// ``EMButtonStyle`` instead ``ButtonStyle`` for your buttons.
///
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .buttonsStyle(.emStyle)
///                 // or .buttonsStyle(EMButtonStyleWrapper())
///         }
///     }
/// }
///
/// struct ContentView: View {
///     var body: some View {
///         VStack {
///             // This button has both
///             `AnimatedTapEMButtonStyle` &
///             `RoundedEMButtonStyle` styles applied.
///             Button(action: {
///             }) {
///                 Text("My Button")
///             }.emButtonStyle(RoundedEMButtonStyle())
///
///             // This button only has the
///             `AnimatedTapEMButtonStyle` style applied.
///             Button(action: {
///             }) {
///                 Text("My Button")
///             }
///
///         }.emButtonStyle(AnimatedTapEMButtonStyle())
///     }
/// }
///
/// struct RoundedEMButtonStyle: EMButtonStyle {
///     func makeBody(
///         content: Content,
///         configuration: Configuration
///     ) -> some View {
///         content
///             .padding(14)
///             .frame(maxWidth: .infinity)
///             .background(Color.blue)
///             .clipShape(.rect(cornerRadius: 16))
///     }
/// }
///
/// struct AnimatedTapEMButtonStyle: EMButtonStyle {
///     func makeBody(
///         content: Content,
///         configuration: Configuration
///     ) -> some View {
///         content
///             .opacity(configuration.isPressed ? 0.4: 1)
///             .scaleEffect(configuration.isPressed ? 0.98: 1)
///             .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
///     }
/// }
/// ```
public struct EMButtonStyleWrapper {
    /// The current style for the button.
    @Environment(\.emButtonStyle) private var style
    
    /// Creates a button style that wraps ``EMButtonStyle`` &
    /// applies them to all buttons in the hierarchy.
    public init() { }
}

// MARK: - ButtonStyle
extension EMButtonStyleWrapper: ButtonStyle {
    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    public func makeBody(configuration: Configuration) -> some View {
        let content = AnyView(configuration.label)
        let configuration = EMButtonStyleConfiguration(
            role: configuration.role,
            isPressed: configuration.isPressed
        )
        VStack {
            AnyView(
                style.makeBody(
                    content: content,
                    configuration: configuration
                )
            )
        }
    }
}

extension ButtonStyle where Self == EMButtonStyleWrapper {
    /// Wrapper ``ButtonStyle`` that wraps ``EMButtonStyle`` &
    /// applies them to all buttons in the hierarchy without the need to use
    /// a custom ``EMButton`` view instead of the built-in ``Button``.
    ///
    /// ``EMButtonStyle`` differs from ``ButtonStyle`` in it's ability
    /// to be chained with other styles.
    ///
    /// Apply this button style at the top of your view hierarchy & start using
    /// ``EMButtonStyle`` instead ``ButtonStyle`` for your buttons.
    ///
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .buttonsStyle(.emStyle)
    ///                 // or .buttonsStyle(EMButtonStyleWrapper())
    ///         }
    ///     }
    /// }
    ///
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             // This button has both
    ///             `AnimatedTapEMButtonStyle` &
    ///             `RoundedEMButtonStyle` styles applied.
    ///             Button(action: {
    ///             }) {
    ///                 Text("My Button")
    ///             }.emButtonStyle(RoundedEMButtonStyle())
    ///
    ///             // This button only has the
    ///             `AnimatedTapEMButtonStyle` style applied.
    ///             Button(action: {
    ///             }) {
    ///                 Text("My Button")
    ///             }
    ///
    ///         }.emButtonStyle(AnimatedTapEMButtonStyle())
    ///     }
    /// }
    ///
    /// struct RoundedEMButtonStyle: EMButtonStyle {
    ///     func makeBody(
    ///         content: Content,
    ///         configuration: Configuration
    ///     ) -> some View {
    ///         content
    ///             .padding(14)
    ///             .frame(maxWidth: .infinity)
    ///             .background(Color.blue)
    ///             .clipShape(.rect(cornerRadius: 16))
    ///     }
    /// }
    ///
    /// struct AnimatedTapEMButtonStyle: EMButtonStyle {
    ///     func makeBody(
    ///         content: Content,
    ///         configuration: Configuration
    ///     ) -> some View {
    ///         content
    ///             .opacity(configuration.isPressed ? 0.4: 1)
    ///             .scaleEffect(configuration.isPressed ? 0.98: 1)
    ///             .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    ///     }
    /// }
    /// ```
    public static var emStyle: EMButtonStyleWrapper {
        return EMButtonStyleWrapper()
    }
}
