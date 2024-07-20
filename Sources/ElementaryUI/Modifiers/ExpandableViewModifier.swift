//
//  ExpandableViewModifier.swift
//  HomePage
//
//  Created by Joe Maghzal on 7/12/24.
//

import SwiftUI

/// ``ViewModifier`` that provides expandable behavior to a view.
///
/// This modifier allows a view to be expanded or hidden based of a ``Bool`` value.
///
/// ```swift
/// struct ContentView: View {
///     @State private var expanded = false
///     var body: some View {
///         VStack {
///             Button(action: {
///                 withAnimation {
///                     expanded.toggle()
///                     print(expanded)
///                 }
///             }) {
///                 Text("Expand")
///             }
///             Color.red
///                 .frame(height: 200)
///                 .expandable(expanded)
///         }
///     }
/// }
/// ```
///
/// - Warning: This is an internal modifier not meant to be used directly.
/// You should use ``expandable(_:)`` instead.
fileprivate struct ExpandableViewModifier: ViewModifier {
    /// The current screen size.
    @State private var size: CGSize?
    
    /// Whether the view is expanded or not.
    fileprivate var expanded: Bool
    
    /// The height of the view based on the expansion state.
    private var bodyHeight: CGFloat? {
        return size.map({expanded ? $0.height: 0})
    }
    
    /// The body of the ``ViewModifier``.
    fileprivate func body(content: Content) -> some View {
        content
            .backgroundSizeListener($size) { _ in
                return size == nil
            }.modifier(AnimatableHeightModifier(height: bodyHeight))
            .clipped()
    }
}

extension ExpandableViewModifier {
    /// ``AnimatableModifier`` that animates the height of a view.
    fileprivate struct AnimatableHeightModifier: AnimatableModifier {
        /// The height of the view to be animated.
        private var height: CGFloat?
        
        /// Creates a new ``AnimatableHeightModifier`` with the specified height.
        ///
        /// - Parameter height: The height to animate to.
        fileprivate init(height: CGFloat?) {
            self.height = height
        }
        
        /// The data to animate.
        fileprivate var animatableData: CGFloat {
            get {
                return height ?? .infinity
            }
            set {
                height = newValue
            }
        }
        
        /// The body of the ``AnimatableModifier``.
        fileprivate func body(content: Content) -> some View {
            content
                .frame(height: height)
        }
    }
}

extension View {
    /// Allows a view to be expanded or hidden based of a ``Bool`` value.
    ///
    /// - Parameter expanded: Value to determine whether the view is expanded or not.
    ///
    /// - Returns: A modified view that can expand or collapse based on the `expanded` value.
    public func expandable(
        _ expanded: Bool
    ) -> some View {
        modifier(ExpandableViewModifier(expanded: expanded))
    }
}
