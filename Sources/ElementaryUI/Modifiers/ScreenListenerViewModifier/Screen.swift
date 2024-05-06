//
//  Screen.swift
//
//
//  Created by Joe Maghzal on 02/03/2024.
//

import SwiftUI

/// Screen size and safe area insets configurations of a ``View``.
///
/// It encapsulates the size of the listener's container view and its safe area insets.
/// You can use this information to adjust your layout accordingly.
public struct Screen: Equatable, Sendable {
    /// The size of the listener's container view.
    public let size: CGSize
    
    /// The safe area inset of the listener's container view.
    public let safeAreaInsets: EdgeInsets
    
    public static let zero = Screen(size: .zero, safeAreaInsets: EdgeInsets())
}

public extension EnvironmentValues {
    /// The screen representation of the listener's container view.
    @EnvironmentValue var screen = Screen.zero
}
