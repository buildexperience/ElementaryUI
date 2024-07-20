//
//  StylableMacroError.swift
//
//
//  Created by Joe Maghzal on 20/07/2024.
//

import Foundation
import SwiftSyntax
import SwiftDiagnostics
import MacrosKit

/// Errors that can occur during the processing of ``StylableMacro``.
package enum StylableMacroError: MacroError, Equatable {
    /// Indicates that the type does not conform to ``View``.
    case missingViewConformance(name: String)
    
    /// Indicates that the provided type has an invalid declaration.
    case invalidDeclaration
}

extension StylableMacroError {
    /// The diagnostic messages.
    package var message: String {
        switch self {
            case .missingViewConformance(let name):
                return "'\(name)' does not conform to protocol 'View'"
            case .invalidDeclaration:
                return "Invalid type declaration"
        }
    }
}
