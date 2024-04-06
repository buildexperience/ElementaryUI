//
//  SkeletonLoadingEnvironment.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// ``EnvironmentKey`` used to store the state of the skeleton loading within the environment.
fileprivate struct SkeletonLoadingEnvironmentKey: EnvironmentKey {
    /// The default value for the `SkeletonLoadingEnvironmentKey`, set to `false`.
    static var defaultValue = false
}

public extension EnvironmentValues {
    /// The current state of the skeleton loading.
    var skeletonLoading: Bool {
        get {
            self[SkeletonLoadingEnvironmentKey.self]
        }
        set {
            self[SkeletonLoadingEnvironmentKey.self] = newValue
        }
    }
}
