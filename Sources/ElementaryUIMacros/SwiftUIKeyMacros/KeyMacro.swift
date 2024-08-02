//
//  KeyMacro.swift
//
//
//  Created by Joe Maghzal on 05/05/2024.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics
import MacrosKit

/// Requirements for defining a macro used to generate property keys for SwiftUI bindings.
///
/// This macro enables the creation of a value that can be stored & retreived from it's key protocol storage:
///
/// ```swift
/// public struct EnvironmentKeyMacro: KeyMacro {
///     public static let keyProtocolName = "EnvironmentKey"
/// }
///
/// @EnvironmentKeyMacro var navigationTitle = "Title"
/// ```
///
/// The macro `EnvironmentKeyMacro` expands to:
///
/// ```swift
/// var navigationTitle = "Title" {
///     get {
///         return self[EnvironmentKey_navigationTitle.self]
///     }
///     set(newValue) {
///         self[EnvironmentKey_navigationTitle.self] = newValue
///     }
/// }
/// ```
package protocol KeyMacro: AccessorMacro {
    /// The name of the key protocol associated with the macro.
    static var keyProtocolName: String {get}
}

// MARK: - Functions
extension KeyMacro {
    /// Decodes a variable binding from a given declaration.
    ///
    /// - Parameter declaration: The declaration syntax.
    /// 
    /// - Returns: The binding element.
    ///
    /// - Throws: ``KeyMacroError.invalidPropertyType`` if the declaration is not a variable declaration of type `var`.
    ///           ``KeyMacroError.invalidDeclaration`` if the declaration is invalid.
    internal static func binding(
        for declaration: some DeclSyntaxProtocol
    ) throws -> PatternBindingListSyntax.Element {
        guard let variableDeclarations = declaration.as(VariableDeclSyntax.self),
              variableDeclarations.bindingSpecifier.text == "var" else {
            throw KeyMacroError.invalidPropertyType
        }
        guard let binding = variableDeclarations.bindings.first else {
            throw KeyMacroError.invalidDeclaration
        }
        return binding
    }
    
    /// Creates a struct key name from a property name & a protocol.
    ///
    /// Using `text = ""` as the binding from the code below, & `EnvironmentKey` as the protocolName, this function produces
    /// `EnvironmentKey_text`.
    ///
    /// - Parameters:
    ///   - binding: The binding element.
    ///   - protocolName: The name of the key protocol.
    ///
    /// - Returns: The struct key name.
    ///
    /// - Throws: ``KeyMacroError.invalidDeclaration`` if the binding is invalid.
    internal static func keyName(
        for binding: PatternBindingListSyntax.Element
    ) throws -> TokenSyntax {
        guard let pattern = binding.pattern.as(IdentifierPatternSyntax.self) else {
            throw KeyMacroError.invalidDeclaration
        }
        
        let name = pattern.identifier.text
        return "\(raw: keyProtocolName)_\(raw: name)" as TokenSyntax
    }
}

// MARK: - AccessorMacro
extension KeyMacro {
    /// Generates the computed property for the given declaration, allowing access to the generated key struct.
    package static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        try withErroHandling(context: context, node: node, onFailure: []) {
            let binding = try binding(for: declaration)
            let keyName = try keyName(for: binding)
            
            return [
                """
                get {
                    return self[\(keyName).self]
                }
                """,
                """
                set(newValue) {
                self[\(keyName).self] = newValue
                }
                """
            ]
        }
    }
}
