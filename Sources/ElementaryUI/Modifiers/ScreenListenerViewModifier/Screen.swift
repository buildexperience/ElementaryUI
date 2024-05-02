//
//  Screen.swift
//
//
//  Created by Joe Maghzal on 02/03/2024.
//

import SwiftUI

/// A structure representing screen size and safe area insets.
///
/// It encapsulates the size of the listener's container view and its safe area insets.
/// You can use this information to adjust your layout accordingly.
///
public struct Screen: Equatable, Sendable {
    /// The size of the listener's container view.
    public let size: CGSize
    
    /// The safe area inset of the listener's container view.
    public let safeAreaInsets: EdgeInsets
    
    public static let zero = Screen(size: .zero, safeAreaInsets: EdgeInsets())
}
