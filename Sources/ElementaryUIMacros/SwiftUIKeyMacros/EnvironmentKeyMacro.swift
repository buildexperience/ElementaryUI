//
//  KeyMacros.swift
//
//
//  Created by Joe Maghzal on 06/05/2024.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import MacrosKit

/// Macro used to generate the an ``EnvironmentKey``.
///
/// This macro creates an ``EnvironmentKey`` from the property it's applied to & generates the corresponding getter & setter for the 
/// property defined in the ``EnvironmentValues`` extension:
///
/// ```swift
/// extension EnvironmentValues {
///     @EnvironmentValue var navigationTitle = "Title"
/// }
///
/// // Expanded
/// extension EnvironmentValues {
///     var navigationTitle = "Title" {
///         get {
///             return self[EnvironmentKey_navigationTitle.self]
///         }
///         set(newValue) {
///             self[EnvironmentKey_navigationTitle.self] = newValue
///         }
///     }
///
///     fileprivate struct EnvironmentKey_navigationTitle: EnvironmentKey {
///         static let defaultValue = true
///     }
/// }
/// ```
/// - Warning: The property must be contained in an ``EnvironmentValues`` extension.
package struct EnvironmentKeyMacro: KeyMacro {
    package static let keyProtocolName = "EnvironmentKey"
}

//MARK: - PeerMacro
extension EnvironmentKeyMacro: PeerMacro {
    /// Generates the key struct for the given declaration, ensuring they adhere to the specified key protocol.
    package static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try withErroHandling(context: context, node: node, onFailure: []) {
            var binding = try binding(for: declaration)
            let keyName = try keyName(for: binding)
            let syntax = IdentifierPatternSyntax(identifier: .identifier("defaultValue "))
            binding.pattern = PatternSyntax(syntax)
            
            let defaultValue = binding.initializer != nil
            guard defaultValue else {
                throw KeyMacroError.missingDefaultValue
            }
            
            return [
                """
                fileprivate struct \(keyName): \(raw: keyProtocolName) {
                    static let \(binding)
                }
                """
            ]
        }
    }
}
