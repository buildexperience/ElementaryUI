//
//  SkeletonRepresentable.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// Protocol for defining the requirements for representing the skeleton data to be used in a ``ForEach`` when skeleton loading is enabled.
public protocol SkeletonRepresentable: Identifiable {
    /// A static property that provides an array of skeleton representations of the conforming type.
    static var skeleton: [Self] {get}
}
