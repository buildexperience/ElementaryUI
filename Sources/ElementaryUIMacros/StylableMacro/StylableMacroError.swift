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
package enum StylableMacroError: Equatable {
    /// Indicates that the type does not conform to ``View``.
    case missingViewConformance(name: String)
    
    /// Indicates that the provided type has an invalid declaration.
    case invalidDeclaration
    
    /// Indicates that the provided access level modifier is invalid.
    case invalidAccessModifier(String)
}

// MARK: - MacroError
extension StylableMacroError: MacroError {
    /// The severity level of the diagnostic message.
    package var severity: DiagnosticSeverity {
        switch self {
            case .missingViewConformance:
                return .note
            case .invalidDeclaration, .invalidAccessModifier:
                return .error
        }
    }
    
    /// The diagnostic messages.
    package var message: String {
        switch self {
            case .missingViewConformance(let name):
                return "'\(name)' does not conform to protocol 'View'"
            case .invalidDeclaration:
                return "Invalid type declaration"
            case .invalidAccessModifier(let modifier):
                return "The access level '\(modifier)' is invalid."
        }
    }
}
