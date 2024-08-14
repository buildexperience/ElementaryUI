//
//  EMTextFieldStyleEnvironment.swift
//
//
//  Created by Joe Maghzal on 02/05/2024.
//

import SwiftUI

extension EnvironmentValues {
#if canImport(SwiftUICore)
    /// The current text field style set in the environment.
    @Entry internal var emTextFieldStyle: (any EMTextFieldStyle) = .default
#else
    /// The current text field style set in the environment.
    @EnvironmentValue internal var emTextFieldStyle: (any EMTextFieldStyle) = .default
#endif
}
