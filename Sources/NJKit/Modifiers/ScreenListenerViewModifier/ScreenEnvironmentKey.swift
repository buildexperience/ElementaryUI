//
//  ScreenEnvironmentKey.swift
//
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

/// ``EnvironmentKey`` used to store screen related information within the environment.
fileprivate struct ScreenEnvironmentKey: EnvironmentKey {
    /// The default value for the ``ScreenEnvironmentKey``, set to `Screen.zero`.
    static let defaultValue = Screen.zero
}

public extension EnvironmentValues {
    /// The screen representation of the listener's container view.
    var screen: Screen {
        get {
            self[ScreenEnvironmentKey.self]
        }
        set {
            self[ScreenEnvironmentKey.self] = newValue
        }
    }
}
