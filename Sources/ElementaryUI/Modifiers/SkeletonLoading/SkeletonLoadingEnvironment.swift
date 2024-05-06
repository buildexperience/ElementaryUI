//
//  SkeletonLoadingEnvironment.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

public extension EnvironmentValues {
    /// The current state of the skeleton loading.
    @EnvironmentValue var skeletonLoading: Bool = false
}
