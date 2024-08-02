//
//  EMVariableFont.swift
//  
//
//  Created by Joe Maghzal on 07/07/2024.
//

import SwiftUI

/// Requirements for defining a variable font, including methods
/// to generate a font with specific attributes or weights.
///
/// **Example Usage:**
/// ```swift
/// enum Nunito: EMVariableFont {
///     case regular
///     var name: String {
///         return "Nunito"
///     }
/// }
///
/// extension Nunito {
///     enum Weight: Double, EMVariableFontWeight {
///         case bold = 800
///         case regular = 400
///
///         var value: Double {
///             return rawValue
///         }
///     }
/// }
/// ```
public protocol EMVariableFont {
    /// Weight of the variable font.
    associatedtype Weight: EMVariableFontWeight
    
    /// The name of the font.
    var name: String {get}
    
    /// Creates a ``Font`` with the specified size & font variation attributes.
    ///
    /// - Parameters:
    ///   - size: The size of the font to be created.
    ///   - attributes: A dictionary of font variation attributes & their corresponding values.
    ///
    /// - Returns: A ``Font`` instance configured with the specified size & attributes.
    func font(_ size: Double, attributes: [FontVariation: Double]) -> Font
    
    /// Creates a ``Font`` with the specified size, weight, & optionally width.
    ///
    /// - Parameters:
    ///   - size: The size of the font to be created.
    ///   - weight: The weight of the font to be applied.
    ///   - width: An optional width for the font.
    ///
    /// - Returns: A ``Font`` instance configured with the specified size, weight, & optionally width.
    func font(_ size: Double, weight: Weight, width: Double?) -> Font
}

// MARK: - Default Implementations
extension EMVariableFont {
    /// Creates a ``Font`` with the specified size & font variation attributes.
    ///
    /// - Parameters:
    ///   - size: The size of the font to be created.
    ///   - attributes: A dictionary of font variation attributes & their corresponding values.
    ///
    /// - Returns: A ``Font`` instance configured with the specified size & attributes.
    public func font(
        _ size: Double,
        attributes: [FontVariation: Double]
    ) -> Font {
        let decriptor = VariableFontDescriptorFactory.make(
            name: name,
            attributes: attributes
        )
        
#if canImport(UIKit)
        let uiFont = UIFont(descriptor: decriptor, size: size)
        return Font(uiFont)
        
#elseif canImport(AppKit)
        guard let nsFont = NSFont(descriptor: decriptor, size: size) else {
            assertionFailure("Could not create a `NSFont` for font \(name)")
            return .system(size: size)
        }
        return Font(nsFont)
#endif
    }
    
    /// Creates a ``Font`` with the specified size, weight, & optionally width.
    ///
    /// - Parameters:
    ///   - size: The size of the font to be created.
    ///   - weight: The weight of the font to be applied.
    ///   - width: An optional width for the font.
    ///
    /// - Returns: A ``Font`` instance configured with the specified size, weight, & optionally width.
    public func font(
        _ size: Double,
        weight: Weight,
        width: Double? = nil
    ) -> Font {
        var attributes: [FontVariation: Double] = [
            .weight: weight.value
        ]
        if let width {
            attributes[.width] = width
        }
        return font(size, attributes: attributes)
    }
}

extension EMVariableFont {
    /// Creates a ``Font`` with the specified text style, weight, & optionally width.
    ///
    /// - Parameters:
    ///   - style: The text style to be used for the font.
    ///   - weight: The weight of the font to be applied.
    ///   - width: An optional width for the font.
    ///
    /// - Returns: A ``Font`` instance configured with the specified text style, weight, & optionally width.
    public func font(
        _ style: Font.TextStyle,
        weight: Weight,
        width: Double? = nil
    ) -> Font {
        return font(style.size, weight: weight, width: width)
    }
}

/// Requirements for defining the weight of a variable font.
///
/// Conforming types must provide a value representing the weight.
///
/// ```swift
/// enum NunitoWeight: Double, EMVariableFontWeight {
///     case bold = 800
///     case regular = 400
///
///     var value: Double {
///         return rawValue
///     }
/// }
/// ```
public protocol EMVariableFontWeight {
    /// The value representing the weight of the font.
    var value: Double {get}
}

/// The variable font variations.
public enum FontVariation: Int {
    /// The weight variation of the font.
    case weight = 2003265652
    
    /// The width variation of the font.
    case width = 2003072104
}
