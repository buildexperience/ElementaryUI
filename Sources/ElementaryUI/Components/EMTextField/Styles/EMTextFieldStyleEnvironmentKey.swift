//
//  EMTextFieldStyleEnvironmentKey.swift
//
//
//  Created by Joe Maghzal on 20/04/2024.
//

import SwiftUI

/// ``EnvironmentKey`` used to access the current ``EMTextFieldStyle`` within the environment.
fileprivate struct EMTextFieldStyleEnvironmentKey: EnvironmentKey {
    /// The default value for the ``EMTextFieldStyleEnvironmentKey``, `DefaultEMTextFieldStyle()`.
    static let defaultValue: (any EMTextFieldStyle) = DefaultEMTextFieldStyle()
}

public extension EnvironmentValues {
    /// The current text field style set in the environment.
    var emTextFieldStyle: (any EMTextFieldStyle) {
        get {
            return self[EMTextFieldStyleEnvironmentKey.self]
        }
        set {
            self[EMTextFieldStyleEnvironmentKey.self] = newValue
        }
    }
}
