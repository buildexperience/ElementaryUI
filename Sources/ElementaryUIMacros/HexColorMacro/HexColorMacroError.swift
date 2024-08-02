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
import HexDecoder

/// Errors that can occur during hex color validation & decoding.
package enum HexColorMacroError: MacroError, Equatable {
    /// Indicates that decoding the hex color failed.
    case decodingFailed(HexColorDecoderError)
    
    /// Indicates that no hex string was provided for decoding.
    case missingHex
}

extension HexColorMacroError {
    /// The diagnostic messages.
    package var message: String {
        switch self {
            case .decodingFailed(let error):
                return error.message
            case .missingHex:
                return "Could not detect a hex string to decode"
        }
    }
}
