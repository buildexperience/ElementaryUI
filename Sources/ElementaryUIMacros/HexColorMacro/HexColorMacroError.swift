//
//  HexColorMacroError.swift
//
//
//  Created by Joe Maghzal on 04/05/2024.
//

import Foundation
import SwiftSyntax
import SwiftDiagnostics
import MacrosKit

/// Errors that can occur during hex color validation & decoding.
package enum HexColorMacroError: MacroError, Equatable {
    /// Indicates that the provided hex color contains invalid characters.
    case invalidCharacters(hex: String, characters: [Character])
    
    /// Indicates that the provided hex color has an invalid length.
    case invalidLength(hex: String)
    
    /// Indicates that decoding the provided hex color failed.
    case decodingFailed(hex: String)

    /// Indicates that no hex string was provided for decoding.
    case missingHex
}

extension HexColorMacroError {
    /// The diagnostic messages.
    package var message: String {
        switch self {
            case .invalidCharacters(let hex, let characters):
                let joinedCharacters = characters.map({String($0)}).joined(separator: ", ")
                return "The hex \"\(hex)\" contains invalid characters: \(joinedCharacters)"
            case .invalidLength(let hex):
                return "The hex \"\(hex)\" must be exactly 6 or 8 characters long"
            case .decodingFailed(let hex):
                return "The hex \"\(hex)\" could not be decoded"
            case .missingHex:
                return "Could not detect a hex string to decode"
        }
    }
}
