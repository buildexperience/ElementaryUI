//
//  Screen.swift
//
//
//  Created by Joe Maghzal on 02/03/2024.
//

import SwiftUI

/// Screen size & safe area insets configurations of a ``View``.
///
/// It encapsulates the size of the listener's container view & its safe area insets.
/// You can use this information to adjust your layout accordingly.
public struct Screen: Equatable, Sendable {
    /// The size of the listener's container view.
    public let size: CGSize
    
    /// The safe area inset of the listener's container view.
    public let safeAreaInsets: EdgeInsets
    
    public static let zero = Screen(size: .zero, safeAreaInsets: EdgeInsets())
}

extension Screen {
    /// Factory for creating ``Screen`` instances.
    internal enum Factory {
        /// Creates a ``Screen`` instance from a ``GeometryProxy``.
        ///
        /// This method extracts the size & safe area insets from the
        /// provided ``GeometryProxy`` & uses them to initialize
        /// a new ``Screen` instance.
        ///
        /// - Parameter proxy: The ``GeometryProxy`` from which
        /// to extract screen size & safe area insets.
        ///
        /// - Returns: A ``Screen`` instance initialized with the size &
        /// safe area insets of the provided `GeometryProxy`.
        internal static func make(proxy: GeometryProxy) -> Screen {
            return Screen(
                size: proxy.frame(in: .local).size,
                safeAreaInsets: proxy.safeAreaInsets
            )
        }
    }
}
