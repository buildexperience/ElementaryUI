//
//  SkeletonLoadingEnvironment.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

extension EnvironmentValues {
    /// The current state of the skeleton loading.
    @EnvironmentValue public var skeletonLoading: Bool = false
}
