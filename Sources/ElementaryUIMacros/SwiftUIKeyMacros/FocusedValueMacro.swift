//
//  FocusedValueMacro.swift
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

/// Macro used to generate the an ``PrefrenceKey``.
///
/// This macro creates a ``FocusedValueKey`` from the property it's applied to & generates the corresponding getter & setter for the 
/// property defined in the ``FocusedValueKey`` extension:
///
/// ```swift
/// extension FocusedValues {
///     @FocusedValue var signInFocus: String?
/// }
///
/// // Expanded
/// extension FocusedValues {
///     var signInFocus: String? {
///         get {
///             return self[FocusedValueKey_signInFocus.self]
///         }
///         set(newValue) {
///             self[FocusedValueKey_signInFocus.self] = newValue
///         }
///     }
///
///     fileprivate struct FocusedValueKey_signInFocus: FocusedValueKey {
///         typealias Value = String
///     }
/// }
/// ```
/// - Warning: The property must be contained in a ``FocusedValues`` extension.
/// - Warning: The property type must be optional.
package struct FocusedValueMacro: KeyMacro {
    package static let keyProtocolName = "FocusedValueKey"
}

// MARK: - PeerMacro
extension FocusedValueMacro: PeerMacro {
    /// Generates the key struct for the given declaration, ensuring they adhere to the specified key protocol.
    package static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        try withErroHandling(context: context, node: node, onFailure: []) {
            let binding = try binding(for: declaration)
            let keyName = try keyName(for: binding)
            
            guard let type = binding.typeAnnotation?.type else {
                throw KeyMacroError.missingTypeAnnotation
            }
            guard let wrappedType = type.as(OptionalTypeSyntax.self)?.wrappedType else {
                let fixItMessage = MacroErrorFixItMessage(
                    message: "Add '?' to the type to make it optional",
                    id: "invalidOptionalTypeAnnotation"
                )
                let fixIt = FixIt(message: fixItMessage, changes: [
                    FixIt.Change.replaceTrailingTrivia(token: "\(type)", newTrivia: "\(type)?")
                ])
                throw KeyMacroError.invalidOptionalTypeAnnotation
                    .withFixIt(fixIt)
            }
            
            return [
                """
                fileprivate struct \(keyName): \(raw: keyProtocolName) {
                    typealias Value = \(wrappedType)
                }
                """
            ]
        }
    }
}
