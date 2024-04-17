//
//  HeadlineWeightRepresentable.swift
//
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI

/// The requirements for representing the weight of the headline font styl.
public protocol HeadlineWeightRepresentable {
    /// The weight to be used for the headline font.
    static var headlineWeight: Self {get}
}

public extension ElementaryFont where Self.Weight: HeadlineWeightRepresentable {
    /// Create a font with the headline text style, size of 17 & weight of `headlineWeight`.
    ///
    /// This font has a size of 17 relative to the ``headline`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `headline` size & `headlineWeight` weight.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func headline(_ weight: Self.Weight? = .headlineWeight) -> Font {
        return custom(.headline, weight: weight)
    }
}
