//
//  ElementaryFont.swift
//  
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// The requirements for defining custom fonts with different weights & styles.
///
/// You can conform ``Weight`` to ``HeadlineWeightRepresentable`` to be able to use the ``headline`` font style which has a size of 17 relative to the `headline` text style, & a weight of `semibold`.
///
/// Implementing ``Weight``  is not required when the font has one weight.
///
/// The function ``static func custom(size: CGFloat, weight: Weight?, relativeTo textStyle: Font.TextStyle?) -> Font`` can be implicitly defined based on the ``Factory``.
///
/// ```swift
/// public struct Halvetica: ElementaryFont {
///     // With Weight
///     enum Weight: String, CaseIterable {
///         case regular, bold
///     }
///
///     enum FontFactory: ElementaryFontFactory {
///         typealias Weight = Halvetica.Weight
///         case regular, italic
///         static var defaultFactory: Nunito.Factory {
///             return .regular
///         }
///         public var fontExtension: String {
///             return "ttf"
///         }
///
///         // With Weight
///         public func font(weight: Weight?) -> String {
///             let weight = weight ?? .regular
///             return "\(Halvetica)-\(weight.rawValue)"
///         }
///
///         // Without Weight
///         public func font(weight: Weight?) -> String {
///             return "Halvetica"
///         }
///     }
/// }
/// ```
///
/// - Note: Implementing ``Weight``  is not required when the font has one weight.
/// - Note: Implementing ``static func custom(size: CGFloat, weight: Weight?, relativeTo textStyle: Font.TextStyle?) -> Font`` as it it implicitly defined based on the ``Factory``.
///
public protocol ElementaryFont {
    /// The diffrent weights of the font.
    ///
    /// - Note: The definition for ``Weight`` is optional, & its default implementation is ``Never``. This can be useful for fonts having a single weight.
    ///
    associatedtype Weight
    
    /// The factory for making & registering the diffrent styles of the font.
    ///
    /// - Note: The definition for ``Factory`` is optional, & its default implementation is ``Never``. This can be useful for fonts having a single style.
    ///
    associatedtype Factory: ElementaryFontFactory where Factory.Weight == Self.Weight
    
    /// Creates a custom font using a size, weight, & relative text style.
    ///
    /// - Parameters:
    ///   - size: The size of the font.
    ///   - weight: The weight of the font.
    ///   - textStyle: The relative text style used to adjust the font size for dynamic text styles.
    ///
    /// - Returns: The custom font.
    ///
    /// - Warning: Using `nil` for the relative text style will use a fixed font size regardless of the text style used by the user.
    ///
    static func custom(size: CGFloat, weight: Self.Weight?, relativeTo textStyle: Font.TextStyle?) -> Font
    
    /// Creates a custom font using a text style & weight.
    ///
    /// - Parameters:
    ///   - style: The text style of the font used for dynamic text styles.
    ///   - weight: The weight of the font.
    ///
    /// - Returns: The custom font.
    ///
    static func custom(_ style: Font.TextStyle, weight: Self.Weight?) -> Font
}

public extension ElementaryFont {
    /// Default implementation of ``Weight``.
    typealias Weight = Never
    
    /// Creates a custom font using a text style & an optional weight.
    ///
    /// - Parameters:
    ///   - style: The text style of the font used for dynamic text styles.
    ///   - weight: The weight of the font, defaults to nil.
    ///
    /// - Returns: The custom font.
    ///
    static func custom(_ style: Font.TextStyle, weight: Self.Weight? = nil) -> Font {
        return custom(size: style.size, weight: weight, relativeTo: style)
    }
}

public extension ElementaryFont {
    /// Creates a custom font using a size, an optional weight, & an optional relative text style.
    ///
    /// - Parameters:
    ///   - size: The size of the font.
    ///   - weight: The weight of the font, defaults to nil.
    ///   - textStyle: The relative text style used to adjust the font size for dynamic text styles, defaults to nil.
    ///
    /// - Returns: The custom font.
    ///
    /// - Warning: Using `nil` for the relative text style will use a fixed font size regardless of the text style used by the user.
    ///
    static func custom(size: CGFloat, weight: Self.Weight? = nil, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
        let name = Factory.defaultFactory.font(weight: weight)
        if let textStyle {
            return Font.custom(name, size: size, relativeTo: textStyle)
        }
        return Font.custom(name, size: size)
    }
}

//MARK: - Pre-defined sizes
public extension ElementaryFont {
    /// Creates a font with the large title text style & size of 34.
    ///
    /// This font has a size of 34 relative to the ``largeTitle`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `largeTitle` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func largeTitle(_ weight: Self.Weight? = nil) -> Font {
        return custom(.largeTitle, weight: weight)
    }
    
    /// Creates a font with the title text style & size of 28.
    ///
    /// This font has a size of 28 relative to the ``title`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func title(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title, weight: weight)
    }
    
    /// Creates a font with the title2 text style & size of 22.
    ///
    /// This font has a size of 22 relative to the ``title2`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title2` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func title2(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title2, weight: weight)
    }
    
    /// Creates a font with the title3 text style & size of 20.
    ///
    /// This font has a size of 20 relative to the ``title3`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `title3` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func title3(_ weight: Self.Weight? = nil) -> Font {
        return custom(.title3, weight: weight)
    }
    
    /// Creates a font with the subheadline text style & size of 15.
    ///
    /// This font has a size of 15 relative to the ``subheadline`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `subheadline` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func subheadline(_ weight: Self.Weight? = nil) -> Font {
        return custom(.subheadline, weight: weight)
    }
    
    /// Creates a font with the body text style & size of 17.
    ///
    /// This font has a size of 17 relative to the ``body`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `body` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func body(_ weight: Self.Weight? = nil) -> Font {
        return custom(.body, weight: weight)
    }
    
    /// Creates a font with the callout text style & size of 16.
    ///
    /// This font has a size of 16 relative to the ``callout`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `callout` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func callout(_ weight: Self.Weight? = nil) -> Font {
        return custom(.callout, weight: weight)
    }
    
    /// Creates a font with the footnote text style & size of 13.
    ///
    /// This font has a size of 13 relative to the ``footnote`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `footnote` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func footnote(_ weight: Self.Weight? = nil) -> Font {
        return custom(.footnote, weight: weight)
    }
    
    /// Creates a font with the caption text style & size of 12.
    ///
    /// This font has a size of 12 relative to the ``caption`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `caption` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func caption(_ weight: Self.Weight? = nil) -> Font {
        return custom(.caption, weight: weight)
    }
    
    /// Creates a font with the caption2 text style & size of 11.
    ///
    /// This font has a size of 11 relative to the ``caption2`` text style.
    ///
    /// - Parameter weight: The weight of the font, defaults to nil.
    /// - Returns: A custom font with a `caption2` size.
    /// - Note: The returned font supports dynamic text styles.
    ///
    static func caption2(_ weight: Self.Weight? = nil) -> Font {
        return custom(.caption2, weight: weight)
    }
}
