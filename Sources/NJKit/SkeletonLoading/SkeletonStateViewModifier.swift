//
//  SkeletonStateViewModifier.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// A view modifier for managing the skeleton loading state of a view.
///
/// `SkeletonStateViewModifier` allows controlling the skeleton loading state of a view by applying placeholder redaction to its content.
/// It reads the skeleton loading state from the environment and applies redaction based on it.
///
/// ```swift
/// struct ContentView: View {
///     @State private var loading = true
///     var body: some View {
///         VStack {
///             Text("Hello, World!")
///                 .skeleton(loading: loading)
///             Button(action: {
///                 loading = true
///             }) {
///                 Text("Load Data")
///             }
///         }
///     }
/// }
/// ```
///
/// - Warning: Not to be used directly, use either ``func skeletonLoadable() -> some View``, or ``func skeleton(loading: Bool) -> some View``.
///
struct SkeletonStateViewModifier: ViewModifier {
//MARK: - Properties
    /// The environment value representing the current redaction reasons.
    @Environment(\.redactionReasons) private var redactionReasons
    
    /// The environment value indicating whether the skeleton loading is active.
    @Environment(\.skeletonLoading) private var skeletonLoading
    
    /// Value representing wether this view can display skeleton loading.
    let loadable: Bool
//MARK: - Computed Properties
    /// Calculates the redaction reasons based on the skeleton loading state.
    private var redactions: RedactionReasons {
        var reasons = redactionReasons
        if loadable {
            if skeletonLoading {
                reasons.insert(.placeholder)
            }
        }else {
            reasons.remove(.placeholder)
        }
        return reasons
    }
//MARK: - Body
    func body(content: Content) -> some View {
        content
            .redacted(reason: redactions)
    }
}

//MARK: - Modifiers
public extension View {
    /// Makes a view display a skeleton when ``EnvironmentValues/skeletonLoading`` is true.
    ///
    /// Use this modifier to indicate that a view should display a skeleton loading view when ``EnvironmentValues/skeletonLoading`` is true.
    ///
    /// ```swift
    /// struct MyCellView: View {
    ///     @State private var loading = true
    ///     var body: some View {
    ///         Text("Some Cell")
    ///             .skeletonLoadable()
    ///     }
    /// }
    /// ```
    /// - Parameter loadable: Wether this view can display skeleton loading.
    /// - Returns: A view that's able to display a skeleton loading view.
    ///
    func skeletonLoading(_ loadable: Bool = true) -> some View {
        modifier(SkeletonStateViewModifier(loadable: loadable))
    }
    
    /// Applies the skeleton loading state to the view with the specified loading status.
    ///
    /// Use this function to indicate whether the view should display a skeleton loading view based on the provided loading status.
    ///
    /// ```swift
    /// struct MyView: View {
    ///     @State private var loading = true
    ///     var body: some View {
    ///         List {
    ///             Text("Some Cell")
    ///                 .skeletonLoadable()
    ///             Button(action: {
    ///                 loading = true
    ///             }) {
    ///                 Text("Load Data")
    ///             }
    ///         }.skeleton(loading: loading)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///    - loading: The status of the skeleton loading.
    ///    - disabled: Wether the view should not handle any user interaction when it's loading, defaults to true.
    ///
    /// - Returns: A view with the skeleton loading state applied.
    /// - Warning: You need to use ``func skeletonLoadable() -> some View`` to make views display the skeleton loading.
    ///
    func skeleton(loading: Bool, disabled: Bool = true) -> some View {
        self
            .environment(\.skeletonLoading, loading)
            .disabled(loading && disabled)
    }
}
