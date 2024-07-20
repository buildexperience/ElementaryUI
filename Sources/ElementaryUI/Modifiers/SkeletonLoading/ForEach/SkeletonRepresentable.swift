//
//  SkeletonRepresentable.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// Requirements for defining a type that can be represented by skeleton data 
/// to be used in a ``ForEach`` when skeleton loading is enabled.
///
/// ```swift
/// struct Character: Identifiable, SkeletonRepresentable {
///     let id = UUID()
///     let name: String
///
///     static let skeleton = [Character(name: "test")]
/// }
/// ```
public protocol SkeletonRepresentable: Identifiable {
    /// The skeleton data to be displayed.
    static var skeleton: [Self] {get}
}
