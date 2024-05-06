//
//  HexColorDecoder.swift
//
//
//  Created by Joe Maghzal on 04/05/2024.
//

import Foundation

/// Hexadecimal color decoder.
///
/// Use this decoder to get the RGBA color components from a hexadecimal string:
///
/// ```swift
/// let hex = "ffffff" // Adding the '#' is optional.
/// let components = HexColorDecoder.decode(hex)
/// ```
package enum HexColorDecoder {
    /// The hex color components.
    package typealias ColorComponents = (red: Int, green: Int, blue: Int, opacity: Int)
    
    /// Decodes the hexadecimal color string into its color components.
    ///
    /// - Parameter hex: The hexadecimal color string to decode.
    /// - Returns: The RGBA color components.
    /// - Throws: ``HexColorMacroError.invalidCharacters`` if the hex contains invalid characters.
    ///           ``HexColorMacroError.invalidLength`` if the length of the hex is invalid.
    ///           ``HexColorMacroError.decodingFailed`` if the decoder failed to decode the hex.
    /// - Note: It's not neccessary to add the '#' prefix to the hex.
    package static func decode(_ hex: String) throws -> ColorComponents {
        let cleanedHex = try cleaned(hex)
        let scanner = Scanner(string: cleanedHex)
        var hexNumber = UInt64.zero
        
        // Scan the hexadecimal string and convert it to a UInt64.
        guard scanner.scanHexInt64(&hexNumber) else {
            throw HexColorMacroError.decodingFailed(hex: hex)
        }
        
        // Extract the RGBA components from the UInt64.
        let components = components(from: hexNumber)
        return components
    }
}

//MARK: - Private Functions
extension HexColorDecoder {
    /// Cleans the hexadecimal color string by validating its characters and ensuring the correct length.
    ///
    /// - Parameter hex: The hexadecimal color string to clean.
    /// - Returns: The cleaned hexadecimal color string.
    /// - Throws: ``HexColorMacroError.invalidCharacters`` if the hex contains invalid characters.
    ///           ``HexColorMacroError.invalidLength`` if the length of the hex is invalid.
    private static func cleaned(_ hex: String) throws -> String {
        var cleanedHex = hex
        // Remove the '#' prefix if present.
        if hex.hasPrefix("#") {
            cleanedHex = String(cleanedHex.dropFirst())
        }
        
        // Check for invalid characters.
        let invalidCharacters = Array(cleanedHex).filter({!$0.isHexDigit})
        guard invalidCharacters.isEmpty else {
            throw HexColorMacroError.invalidCharacters(hex: hex, characters: invalidCharacters)
        }
        
        // Ensure the correct length (6 or 8 characters).
        let hexCount = cleanedHex.count
        if hexCount == 8 {
            return cleanedHex
        }else if hexCount == 6 {
            return "\(cleanedHex)ff"
        }
        throw HexColorMacroError.invalidLength(hex: hex)
    }
    
    /// Extracts the color components from the given hexadecimal number.
    ///
    /// - Parameter hexNumber: The hexadecimal number to extract color components from.
    /// - Returns: A tuple containing the red, green, blue, & opacity components.
    private static func components(from hexNumber: UInt64) -> ColorComponents {
        let red = Int((hexNumber & 0xff000000) >> 24)
        let green = Int((hexNumber & 0x00ff0000) >> 16)
        let blue = Int((hexNumber & 0x0000ff00) >> 8)
        let opacity = Int(hexNumber & 0x000000ff)
        return (red, green, blue, opacity)
    }
}
