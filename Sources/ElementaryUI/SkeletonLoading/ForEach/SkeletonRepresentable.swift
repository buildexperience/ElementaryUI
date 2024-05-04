//
//  SkeletonRepresentable.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// Requirements for defining a type that can be represented by skeleton data to be used in a ``ForEach`` when skeleton loading is enabled.
public protocol SkeletonRepresentable: Identifiable {
    /// The skeleton data to be displayed.
    static var skeleton: [Self] {get}
}
