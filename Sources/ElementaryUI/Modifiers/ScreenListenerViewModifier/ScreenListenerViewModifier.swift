//
//  ScreenListenerViewModifier.swift
//
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

/// ``ViewModifier`` for observing screen size changes.
///
/// This modifier allows observing changes in the screen size & safe area insets.
/// It adjusts the view's behavior based on these changes.
///
/// ```swift
/// struct ContentView: View {
///     @State private var screen = Screen.zero
///     var body: some View {
///         VStack {
///             Text("Hello, World!")
///                 .frame(height: screen.height / 4)
///         }.frame(maxWidth: .infinity, maxHeight: .infinity)
///         .sizeListener($screen) // Updates the screen property
///     }
/// }
/// ```
/// 
/// - Warning: This is an internal modifier not meant to be used directly. 
/// You should use either ``sizeListener()``, or ``sizeListener(_:)`` instead.
fileprivate struct ScreenListenerViewModifier: ViewModifier {
    /// The value indicating whether to bind the screen size changes to a ``Binding`` property.
    private let bindingScreen: Bool
    
    /// The binding value to the current screen size.
    @Binding private var screen: Screen
    
    /// The body of the ``ViewModifier``.
    fileprivate func body(content: Content) -> some View {
        GeometryReader { proxy in
            let geometryScreen = Screen.Factory.make(proxy: proxy)
            if bindingScreen {
                content
                    .preference(key: ScreenKey.self, value: geometryScreen)
            }else {
                content
                    .environment(\.screen, geometryScreen)
            }
        }.onPreferenceChange(ScreenKey.self) { newValue in
            screen = newValue
        }
    }
}

// MARK: - Initializers
extension ScreenListenerViewModifier {
    /// Creates a scren listener modifier using a ``Binding`` to the ``Screen`` object.
    ///
    /// - Parameter screen: The ``Binding`` to the current ``Screen`` object.
    fileprivate init(screen: Binding<Screen>? = nil) {
        self.bindingScreen = screen != nil
        self._screen = screen ?? .constant(.zero)
    }
}

// MARK: - Modifiers
extension View {
    /// Adds a listener to a view's size & safe area insets.
    ///
    /// You can access the updated ``Screen`` object using ``EnvironmentValues/screen``.
    ///
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .sizeListener() //Propagates the updated Screen object.
    ///         }
    ///     }
    /// }
    ///
    /// struct ContentView: View {
    ///     @Environment(\.screen) private var screen //Access the updated Screen object.
    ///     var body: some View {
    ///         Color.blue
    ///             .frame(width: screen.size.width)
    ///     }
    /// }
    /// ```
    ///
    /// - Returns: A view wrapped in a ``GeometryReader`` that propagates
    /// the up-to-date size & safe area insets to the environment.
    public func sizeListener() -> some View {
        modifier(ScreenListenerViewModifier())
    }
    
    /// Adds a listener to a view's size & safe area insets & binds them to a ``Binding`` property.
    ///
    /// You can access the updated ``Screen`` object using the passed ``Binding`` property.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var screen = Screen.zero
    ///     var body: some View {
    ///         Color.blue
    ///             .sizeListener($screen)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter screen: A ``Binding`` to the current ``Screen`` object.
    /// 
    /// - Returns: A view wrapped in a ``GeometryReader`` that propagates 
    /// the up-to-date size & safe area insets to the passed ``Binding``.
    public func sizeListener(_ screen: Binding<Screen>) -> some View {
        modifier(ScreenListenerViewModifier(screen: screen))
    }
}
