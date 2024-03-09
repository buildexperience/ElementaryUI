//
//  ScreenEnvironmentKey.swift
//
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

fileprivate struct ScreenEnvironmentKey: EnvironmentKey {
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
