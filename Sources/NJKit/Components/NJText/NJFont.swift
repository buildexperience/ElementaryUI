//
//  NJFont.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// Protocol for defining fonts with customizable weights.
///
/// Conforming types must provide a `font` property representing the font and implement the `weight` method to allow customization of the font's weight.
/// ```swift
/// struct CustomFont: NJFont {
///     typealias Weight = String
///     private let fontName = "Halvetica"
///     var font: Font {
///         return Font.custom(fontName, size: 12)
///     }
///     func with(weight: Weight) -> Font {
///         return Font.custom("\(fontName)-\(weight)", size: 12)
///     }
/// }
/// ```
/// - Note: The associated type `Weight` represents the type of weight that can be applied to the font.
///
public protocol NJFont {
    /// The type representing the weight that can be applied to the font.
    associatedtype Weight
    
    /// The `Font` associated with this protocol.
    var font: Font {get}
    
    /// Returns a font with a custom weight.
    ///
    /// - Parameter weight: The custom weight to be applied to the font.
    /// - Returns: A font with the specified weight applied.
    ///
    func with(weight: Weight) -> Font
}

extension NJFont {
    /// Returns a font with a custom weight.
    ///
    /// - Parameter weight: The custom weight to be applied to the font. If `nil` is provided, the default weight is used.
    /// - Returns: A font with the specified weight applied.
    ///
    func with(weight: Weight?) -> Font {
        return weight.map({with(weight: $0)}) ?? font
    }
}

extension Font: NJFont {
    public var font: Font {
        return self
    }
    public func with(weight: Weight) -> Font {
        return font.weight(weight)
    }
}
