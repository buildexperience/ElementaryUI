//
//  EMFontPredifinedSizes.swift
//  
//
//  Created by Joe Maghzal on 11/05/2024.
//

import SwiftUI

extension EMFont {
    /// Creates a font with the large title text style & size of 34.
    ///
    /// This font has a size of 34 relative to the ``largeTitle`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `largeTitle` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func largeTitle(_ weight: Self.Weight? = nil) -> Font {
        return custom(.largeTitle, weight: weight)
    }
    
    /// Creates a font with the title text style & size of 28.
    ///
    /// This font has a size of 28 relative to the ``title`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func title(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title, weight: weight)
    }
    
    /// Creates a font with the title2 text style & size of 22.
    ///
    /// This font has a size of 22 relative to the ``title2`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title2` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func title2(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title2, weight: weight)
    }
    
    /// Creates a font with the title3 text style & size of 20.
    ///
    /// This font has a size of 20 relative to the ``title3`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title3` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func title3(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title3, weight: weight)
    }
    
    /// Creates a font with the subheadline text style & size of 15.
    ///
    /// This font has a size of 15 relative to the ``subheadline`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `subheadline` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func subheadline(_ weight: Self.Weight? = nil) -> Font {
        return custom(.subheadline, weight: weight)
    }
    
    /// Creates a font with the body text style & size of 17.
    ///
    /// This font has a size of 17 relative to the ``body`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `body` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func body(_ weight: Self.Weight? = nil) -> Font {
        return custom(.body, weight: weight)
    }
    
    /// Creates a font with the callout text style & size of 16.
    ///
    /// This font has a size of 16 relative to the ``callout`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `callout` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func callout(_ weight: Self.Weight? = nil) -> Font {
        return custom(.callout, weight: weight)
    }
    
    /// Creates a font with the footnote text style & size of 13.
    ///
    /// This font has a size of 13 relative to the ``footnote`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `footnote` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func footnote(_ weight: Self.Weight? = nil) -> Font {
        return custom(.footnote, weight: weight)
    }
    
    /// Creates a font with the caption text style & size of 12.
    ///
    /// This font has a size of 12 relative to the ``caption`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `caption` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func caption(_ weight: Self.Weight? = nil) -> Font {
        return custom(.caption, weight: weight)
    }
    
    /// Creates a font with the caption2 text style & size of 11.
    ///
    /// This font has a size of 11 relative to the ``caption2`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `caption2` size.
    /// - Note: The returned font supports dynamic text styles.
    @inlinable
    public static func caption2(_ weight: Self.Weight? = nil) -> Font {
        return custom(.caption2, weight: weight)
    }
}
