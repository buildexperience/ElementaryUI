//
//  ConditionalViewModifier.swift
//
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

public extension View {
    /// Conditionally hides a view.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var showText = false
    ///     var body: some View {
    ///         Text("Hello, world!")
    ///             .hidden(!showText)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameter condition: The condition to use when hiding a ``View``.
    /// - Returns: A view that becomes hiden when the given condition is satisfied.
    /// - Warning: The type of the returned view is different from the one the modifier is applied to.
    @ViewBuilder func hidden(_ condition: Bool) -> some View {
        if !condition {
            self
        }
    }
}

public extension View {
    /// Conditionally applies a builder to the view if the specified condition is true.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var formatTitle = true
    ///     var body: some View {
    ///         Text("Hello")
    ///              .if(formatTitle) { text in
    ///                  text
    ///                      .font(.title)
    ///              } + //Error: The modifier returns some View, not Text.
    ///          Text(", World")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - condition: The boolean condition to determine whether to apply the builder.
    ///   - builder: The view builder closure to be applied.
    ///
    /// - Returns: A view with the specified modifications applied conditionally.
    /// - Warning: The type of the returned view is different from the one the modifier is applied to.
    ///   Use ``if(_:_:)`` if you want the return type to remain the same.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, @ViewBuilder _ builder: (_ content: Self) -> Content) -> some View {
        if condition {
            builder(self)
        }else {
            self
        }
    }
    
    /// Conditionally applies a builder to the view if the specified condition is true.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var formatTitle = true
    ///     var body: some View {
    ///         Text("Hello")
    ///              .if(formatTitle) { text in
    ///                  text
    ///                      .font(.title)
    ///              } + //The modifier returns Text
    ///          Text(", World")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - condition: The boolean condition to determine whether to apply the builder.
    ///   - builder: The view builder closure to be applied.
    ///
    /// - Returns: A view with the specified modifications applied conditionally.
    /// - Note: The type of the returned view is the same as the one the modifier is applied to.
    func `if`(_ condition: Bool, @ViewBuilder _ builder: (_ content: Self) -> Self) -> Self {
        if condition {
            return builder(self)
        }
        return self
    }
}

public extension View {
    /// Conditionally applies a builder to the view if the specified optional value is non-nil.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var title: String?
    ///     var body: some View {
    ///         Text("Hello")
    ///             .if(let: title) { text, title in
    ///                 text +
    ///                 Text(title)
    ///                     .font(.title)
    ///             } + //Error: The modifier returns some View, not Text.
    ///         Text(", World")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - value: The optional value to determine whether to apply the builder.
    ///   - builder: The view builder closure to be applied conditionally.
    ///
    /// - Returns: A view with the specified modifications applied conditionally.
    /// - Warning: The type of the returned view is different from the one the modifier is applied to.
    ///   Use ``if(let:_:)`` if you want the return type to remain the same.
    @ViewBuilder func `if`<Content: View, T>(`let` optional: T?, @ViewBuilder _ builder: (_ content: Self, _ value: T) -> Content) -> some View {
        if let optional {
            builder(self, optional)
        }else {
            self
        }
    }
    
    /// Conditionally applies a builder to the view if the specified optional value is non-nil.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var title: String?
    ///     var body: some View {
    ///         Text("Hello")
    ///             .if(let: title) { text, title in
    ///                 text +
    ///                 Text(title)
    ///                     .font(.title)
    ///             } + //The modifier returns Text
    ///         Text(", World")
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - value: The optional value to determine whether to apply the builder.
    ///   - builder: The view builder closure to be applied conditionally.
    ///
    /// - Returns: A view with the specified modifications applied conditionally.
    /// - Note: The type of the returned view is the same as the one the modifier is applied to.
    func `if`<T>(`let` value: T?, @ViewBuilder _ builder: (_ content: Self, _ value: T) -> Self) -> Self {
        if let value {
            return builder(self, value)
        }
        return self
    }
}
