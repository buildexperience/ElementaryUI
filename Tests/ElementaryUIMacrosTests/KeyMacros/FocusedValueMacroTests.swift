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
//MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "FocusedValue": FocusedValueMacro.self
    ]
   
//MARK: - Tests
    func testPrefrenceKeyMacro() throws {
        let protocolName = FocusedValueMacro.keyProtocolName
        assertMacroExpansion(
            """
            @FocusedValue var signInFocus: Bool?
            """,
            expandedSource: """
            var signInFocus: Bool? {
                get {
                    return self [\(protocolName)_signInFocus.self]
                }
                set(newValue) {
                    self [\(protocolName)_signInFocus.self] = newValue
                }
            }
            
            fileprivate struct \(protocolName)_signInFocus: \(protocolName) {
                typealias Value = Bool
            }
            """,
            macros: testMacros
        )
    }
}
#endif
