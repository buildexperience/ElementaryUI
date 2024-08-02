//
//  EnvironmentKeyMacroTests.swift
//
//
//  Created by Joe Maghzal on 06/05/2024.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ElementaryUIMacros)
import ElementaryUIMacros

final class EnvironmentKeyMacroTests: XCTestCase {
// MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "EnvironmentValue": EnvironmentKeyMacro.self
    ]
    
// MARK: - Expansion Tests
    func testEnvironmentKeyMacro() {
        assertMacroExpansion(
            """
            @EnvironmentValue var skeletonLoading = true
            """,
            expandedSource: """
            var skeletonLoading {
                get {
                    return self [EnvironmentKey_skeletonLoading.self]
                }
                set(newValue) {
                    self [EnvironmentKey_skeletonLoading.self] = newValue
                }
            }
            
            fileprivate struct EnvironmentKey_skeletonLoading: EnvironmentKey {
                static let defaultValue = true
            }
            """,
            macros: testMacros
        )
    }
    
// MARK: - Validation Tests
    func testEnvironmentKeyMacroFailsWithInvalidPropertyTypeWhenPropertyIsLet() {
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
            @EnvironmentValue let skeletonLoading = true
            """,
            expandedSource: """
            let skeletonLoading = true
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
    
    func testEnvironmentKeyMacroFailsWithMissingDefaultValueWhenPropertyHasOnlyAName() {
        // Expect 1 diagnostic since only the PeerMacro fails & throws the error.
        let expectedDiagnostics = [
            // The property is missing a default value
            DiagnosticSpec(
                message: KeyMacroError.missingDefaultValue.message,
                line: 1,
                column: 1
            )
        ]
        
        assertMacroExpansion(
            """
            @EnvironmentValue var skeletonLoading
            """,
            expandedSource: """
            var skeletonLoading {
                get {
                    return self [EnvironmentKey_skeletonLoading.self]
                }
                set(newValue) {
                    self [EnvironmentKey_skeletonLoading.self] = newValue
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
    
    func testEnvironmentKeyMacroFailsWithMissingDefaultValueWhenPropertyHasATypeButNoValue() {
        // Expect 1 diagnostic since only the PeerMacro fails & throws the error.
        let expectedDiagnostics = [
            // The property is missing a default value
            DiagnosticSpec(
                message: KeyMacroError.missingDefaultValue.message,
                line: 1,
                column: 1
            )
        ]
        
        assertMacroExpansion(
            """
            @EnvironmentValue var skeletonLoading: Bool
            """,
            expandedSource: """
            var skeletonLoading: Bool {
                get {
                    return self [EnvironmentKey_skeletonLoading.self]
                }
                set(newValue) {
                    self [EnvironmentKey_skeletonLoading.self] = newValue
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
}
#endif
