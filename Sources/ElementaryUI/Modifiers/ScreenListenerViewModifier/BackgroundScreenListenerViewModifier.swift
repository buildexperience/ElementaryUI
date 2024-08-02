//
//  BackgroundScreenListenerViewModifier.swift
//  
//
//  Created by Joe Maghzal on 15/07/2024.
//

import SwiftUI

/// ``ViewModifier`` that listens to changes in the view's size & updates a binding.
///
/// This modifier uses a ``GeometryReader`` in the background of it's content.
///
/// ```swift
/// struct ContentView: View {
///     @State var size: CGSize?
///     var body: some View {
///         Color.red
///             .backgroundSizeListener($size) { newSize in
///                 return size != newSize
///             }
///     }
/// }
/// ```
///
/// - Warning: This is an internal modifier not meant to be used directly.
/// You should use either ``backgroundSizeListener(_:, _:)``, or ``backgroundSizeListener(_:, _:)`` instead.
fileprivate struct BackgroundScreenListenerViewModifier: ViewModifier {
    /// Binding to the size that should be updated.
    @Binding fileprivate var size: CGSize?
    
    /// Optional closure to determine if the size should be updated.
    fileprivate let shouldUpdate: ((_ newSize: CGSize) -> Bool)?
    
    /// The body of the ``ViewModifier``.
    fileprivate func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    let geometryScreen = Screen.Factory.make(proxy: proxy)
                    content
                        .preference(key: ScreenKey.self, value: geometryScreen)
                }.opacity(0)
            }.onPreferenceChange(ScreenKey.self) { newValue in
                let newSize = newValue.size
                guard (shouldUpdate?(newSize) ?? true) else {return}
                size = newSize
            }
    }
}

// MARK: - Modifiers
extension View {
    /// Adds a background size listener to the view.
    ///
    /// This method listens for changes in the view's size
    /// & updates the provided binding with the new size.
    /// It also allows an optional closure to determine if the
    /// size should be updated.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State var size: CGSize?
    ///     var body: some View {
    ///         Color.red
    ///             .backgroundSizeListener($size) { newSize in
    ///                 return size != newSize
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - size: A binding to the size that should be updated.
    ///   - shouldUpdate: An optional closure to determine 
    ///   if the size should be updated.
    ///
    /// - Returns: A view that applies the background size listener.
    ///
    /// - Note: The ``GeometryReader`` is added to the 
    /// background of the view.
    ///
    /// - Note: This function uses an optional ``CGSize?`` binding.
    public func backgroundSizeListener(
        _ size: Binding<CGSize?>,
        _ shouldUpdate: ((_ newSize: CGSize) -> Bool)? = nil
    ) -> some View {
        modifier(
            BackgroundScreenListenerViewModifier(
                size: size,
                shouldUpdate: shouldUpdate
            )
        )
    }
    
    /// Adds a background size listener to the view.
    ///
    /// This method listens for changes in the view's size
    /// & updates the provided binding with the new size.
    /// It also allows an optional closure to determine if the
    /// size should be updated.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State var size = CGSize.zero
    ///     var body: some View {
    ///         Color.red
    ///             .backgroundSizeListener($size) { newSize in
    ///                 return size != newSize
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - size: A binding to the size that should be updated.
    ///   - shouldUpdate: An optional closure to determine
    ///   if the size should be updated.
    ///
    /// - Returns: A view that applies the background size listener.
    ///
    /// - Note: The ``GeometryReader`` is added to the
    /// background of the view.
    ///
    /// - Note: This function uses a non optional ``CGSize`` binding.
    public func backgroundSizeListener(
        _ size: Binding<CGSize>,
        _ shouldUpdate: ((_ newSize: CGSize) -> Bool)? = nil
    ) -> some View {
        modifier(
            BackgroundScreenListenerViewModifier(
                size: size.map({$0}, {$0 ?? .zero}),
                shouldUpdate: shouldUpdate
            )
        )
    }
}
