//
//  HexColorDecoderError.swift
//
//
//  Created by Joe Maghzal on 02/08/2024.
//

import Foundation

/// Errors that can occur during hex color validation & decoding.
package enum HexColorDecoderError: Error, Equatable {
    /// Indicates that the provided hex color contains invalid characters.
    case invalidCharacters(hex: String, characters: [Character])
    
    /// Indicates that the provided hex color has an invalid length.
    case invalidLength(hex: String)
    
    /// Indicates that decoding the provided hex color failed.
    case decodingFailed(hex: String)
}

extension HexColorDecoderError {
    /// The error messages.
    package var message: String {
        switch self {
            case .invalidCharacters(let hex, let characters):
                let joinedCharacters = characters.map({String($0)}).joined(separator: ", ")
                return "The hex \"\(hex)\" contains invalid characters: \(joinedCharacters)"
            case .invalidLength(let hex):
                return "The hex \"\(hex)\" must be exactly 6 or 8 characters long"
            case .decodingFailed(let hex):
                return "The hex \"\(hex)\" could not be decoded"
        }
    }
}
