//
//  ScreenKeys.swift
//
//
//  Created by Joe Maghzal on 15/07/2024.
//

import SwiftUI

extension EnvironmentValues {
    /// The screen representation of the listener's container view.
#if canImport(SwiftUICore)
    @Entry public var screen = Screen.zero
#else
    @EnvironmentValue public var screen = Screen.zero
#endif
}

/// ``PreferenceKey`` for updating the screen size information.
public struct ScreenKey: PreferenceKey {
    /// The default value for the screen size.
    public static let defaultValue = Screen.zero
    
    /// Combines a new screen size value with the current value.
    public static func reduce(value: inout Screen, nextValue: () -> Screen) {
        value = nextValue()
    }
}
