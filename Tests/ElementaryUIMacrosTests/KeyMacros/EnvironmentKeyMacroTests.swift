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
    //MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "EnvironmentValue": EnvironmentKeyMacro.self
    ]
    
    //MARK: - Tests
    func testEnvironmentKeyMacro() throws {
        let protocolName = EnvironmentKeyMacro.keyProtocolName
        assertMacroExpansion(
            """
            @EnvironmentValue var skeletonLoading = true
            """,
            expandedSource: """
            var skeletonLoading = true {
                get {
                    return self [\(protocolName)_skeletonLoading.self]
                }
                set(newValue) {
                    self [\(protocolName)_skeletonLoading.self] = newValue
                }
            }
            
            fileprivate struct \(protocolName)_skeletonLoading: \(protocolName) {
                static let defaultValue = true
            }
            """,
            macros: testMacros
        )
    }
}
#endif
