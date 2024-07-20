//
//  VariableFontDescriptorFactory.swift
//
//
//  Created by Joe Maghzal on 07/07/2024.
//

import SwiftUI

/// Factory for creating variable font descriptors.
///
/// This enum provides static methods to create ``UIFontDescriptor``
/// or ``NSFontDescriptor`` with variable font attributes based on the platform.
/// It maps font variation attributes to the appropriate descriptor format for **iOS** or **macOS**.
public enum VariableFontDescriptorFactory {
#if canImport(UIKit)
    /// Creates a ``UIFontDescriptor`` with the specified name & font variation attributes.
    ///
    /// - Parameters:
    ///   - name: The name of the font.
    ///   - attributes: A dictionary of font variation attributes & their corresponding values.
    ///
    /// - Returns: A ``UIFontDescriptor`` instance configured with the specified name & attributes.
    public static func make(
        name: String,
        attributes: [FontVariation: Double]
    ) -> UIFontDescriptor {
        let mappedAttributes = attributes.map { key, value in
            return (key.rawValue, value)
        }
        let dictionary = Dictionary(uniqueKeysWithValues: mappedAttributes)
        let fontAttributes: [UIFontDescriptor.AttributeName: Any] = [
            .name: name,
            kCTFontVariationAttribute as UIFontDescriptor.AttributeName: dictionary
        ]
        return UIFontDescriptor(fontAttributes: fontAttributes)
    }
    
#elseif canImport(AppKit)
    /// Creates an ``NSFontDescriptor`` with the specified name & font variation attributes.
    ///
    /// - Parameters:
    ///   - name: The name of the font.
    ///   - attributes: A dictionary of font variation attributes & their corresponding values.
    /// - Returns: An ``NSFontDescriptor`` instance configured with the specified name & attributes.
    public static func make(
        name: String,
        attributes: [FontVariation: Double]
    ) -> NSFontDescriptor {
        let mappedAttributes = attributes.map { key, value in
            return (key.rawValue, value)
        }
        let dictionary = Dictionary(uniqueKeysWithValues: mappedAttributes)
        let fontAttributes: [NSFontDescriptor.AttributeName: Any] = [
            .name: name,
            .variation: dictionary
        ]
        return NSFontDescriptor(fontAttributes: fontAttributes)
    }
#endif
}
