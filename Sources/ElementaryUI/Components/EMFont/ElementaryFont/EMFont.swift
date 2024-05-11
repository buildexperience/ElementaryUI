//
//  EMFont.swift
//  
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// Requirements for defining custom fonts with different weights & styles.
///
/// You can conform ``Weight`` to ``HeadlineWeightRepresentable`` to be able to use the ``headline`` font style which 
/// has a size of 17 relative to the `headline` text style, & a weight of `semibold`.
///
/// Implementing ``Weight``  is not required when the font has one weight.
///
/// The function ``custom(size:weight:relativeTo:)-600rf`` can be implicitly defined based on the ``Factory``.
///
/// ```swift
/// public struct Halvetica: EMFont {
///     // With Weight
///     enum Weight: String, CaseIterable {
///         case regular, bold
///     }
///     public static func custom(
///         size: CGFloat,
///         weight: Self.Weight?,
///         relativeTo textStyle: Font.TextStyle?
///         ) -> Font {
///         let name = "Halvetica-\(weight.rawValue)"
///         if let textStyle {
///             return Font.custom(name, size: size, relativeTo: textStyle)
///         }
///         return Font.custom(name, size: size)
///     }
/// }
/// ```
///
/// - Note: Implementing ``Weight``  is not required when the font has one weight.
public protocol EMFont {
    /// The diffrent weights of the font.
    ///
    /// - Note: The definition for ``Weight`` is optional, & its default implementation is ``Never``. This can be useful for fonts 
    /// having a single weight.
    associatedtype Weight
    
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
    static func custom(
        size: CGFloat,
        weight: Self.Weight?,
        relativeTo textStyle: Font.TextStyle?
    ) -> Font
    
    /// Creates a custom font using a text style & weight.
    ///
    /// - Parameters:
    ///   - style: The text style of the font used for dynamic text styles.
    ///   - weight: The weight of the font.
    ///
    /// - Returns: The custom font.
    static func custom(_ style: Font.TextStyle, weight: Self.Weight?) -> Font
}

extension EMFont {
    /// Default implementation of ``Weight``.
    public typealias Weight = Never
    
    /// Creates a custom font using a text style & an optional weight.
    ///
    /// - Parameters:
    ///   - style: The text style of the font used for dynamic text styles.
    ///   - weight: The weight of the font, defaults to nil.
    ///
    /// - Returns: The custom font.
    public static func custom(_ style: Font.TextStyle, weight: Self.Weight? = nil) -> Font {
        return custom(size: style.size, weight: weight, relativeTo: style)
    }
}
