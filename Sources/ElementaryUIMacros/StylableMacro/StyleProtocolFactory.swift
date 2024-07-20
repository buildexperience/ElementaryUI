//
//  StylableMacroArgument.swift
//
//
//  Created by Joe Maghzal on 29/06/2024.
//

import Foundation
import SwiftSyntax

extension StylableMacro {
    /// Enum representing the possible arguments for the ``StylableMacro``.
    internal enum Argument: String {
        /// Argument key for the style protocol name.
        case styleProtocol
        
        /// Argument key for the configurations type.
        case configurations
        
        /// Argument key for the environment key name.
        case environmentKey
    }
}

extension StylableMacro.Argument {
    /// Factory for reading the ``StylabelMacro`` arguments.
    internal struct Factory {
        /// The macro arguments.
        internal let arguments: [String?: TokenSyntax]?
        
        /// Retrieves the argument value for the given key or returns a default value if the key is not found.
        ///
        /// - Parameters:
        ///   - key: The key for the argument to retrieve.
        ///   - defaultValue: The default value to return if the argument key is not found.
        ///
        /// - Returns: The argument value for the given key or the default value if the key is not found.
        internal func argument(
            key: StylableMacro.Argument,
            defaultValue: TokenSyntax
        ) -> TokenSyntax {
            return arguments?[key.rawValue] ?? defaultValue
        }
    }
}
