//
//  SkeletonLoadingEnvironment.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

extension EnvironmentValues {
// TODO: - Remove `canImport(SwiftUICore)` when Xcode 16 comes out of beta.
#if canImport(SwiftUICore)
    /// The current state of the skeleton loading.
    @Entry public var skeletonLoading = false
#else
    /// The current state of the skeleton loading.
    @EnvironmentValue public var skeletonLoading = false
#endif
}
