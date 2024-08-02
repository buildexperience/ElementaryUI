//
//  FocusedValueMacroTests.swift
//
//
//  Created by Joe Maghzal on 05/05/2024.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ElementaryUIMacros)
import ElementaryUIMacros

final class FocusedValueMacroTests: XCTestCase {
// MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "FocusedValue": FocusedValueMacro.self
    ]
    
// MARK: - Expansion Tests
    func testFocusedValueMacro() {
        assertMacroExpansion(
            """
            @FocusedValue var signInFocus: Bool?
            """,
            expandedSource: """
            var signInFocus: Bool? {
                get {
                    return self [FocusedValueKey_signInFocus.self]
                }
                set(newValue) {
                    self [FocusedValueKey_signInFocus.self] = newValue
                }
            }
            
            fileprivate struct FocusedValueKey_signInFocus: FocusedValueKey {
                typealias Value = Bool
            }
            """,
            macros: testMacros
        )
    }
    
// MARK: - Validation Tests
    func testFocusedValueMacroFailsWithInvalidPropertyTypeWhenPropertyIsLet() {
        // Invalid property type, the macro requires var instead of let.
        let diagnostic = DiagnosticSpec(
            message: KeyMacroError.invalidPropertyType.message,
            line: 1,
            column: 1
        )
        
        // Expect 2 diagnostics since both the PeerMacro & the AccessorMacro fail & throw the error.
        let expectedDiagnostics = [diagnostic, diagnostic]
        
        assertMacroExpansion(
            """
            @FocusedValue let signInFocus: Bool?
            """,
            expandedSource: """
            let signInFocus: Bool?
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
    
    func testFocusedValueMacroFailsWithMissingTypeAnnotationWhenPropertyDoesNotHaveAType() {
        // Expect 1 diagnostic since only the PeerMacro fails & throws the error.
        let expectedDiagnostics = [
            // The property has no type.
            DiagnosticSpec(
                message: KeyMacroError.missingTypeAnnotation.message,
                line: 1,
                column: 1
            )
        ]
        
        assertMacroExpansion(
            """
            @FocusedValue var signInFocus
            """,
            expandedSource: """
            var signInFocus {
                get {
                    return self [FocusedValueKey_signInFocus.self]
                }
                set(newValue) {
                    self [FocusedValueKey_signInFocus.self] = newValue
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
    
    func testFocusedValueMacroFailsWithInvalidOptionalTypeAnnotationWhenPropertyIsNotOptional() {
        let expectedFixIt = FixItSpec(message: "Add '?' to the type to make it optional")
        // Expect 1 diagnostic since only the PeerMacro fails & throws the error.
        let expectedDiagnostics = [
            // The property's type is not optional.
            DiagnosticSpec(
                message: KeyMacroError.invalidOptionalTypeAnnotation.message,
                line: 1,
                column: 1,
                fixIts: [expectedFixIt]
            )
        ]
        
        assertMacroExpansion(
            """
            @FocusedValue var signInFocus: Bool
            """,
            expandedSource: """
            var signInFocus: Bool {
                get {
                    return self [FocusedValueKey_signInFocus.self]
                }
                set(newValue) {
                    self [FocusedValueKey_signInFocus.self] = newValue
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
}
#endif
