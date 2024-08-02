//
//  HexColorMacroTests.swift
//
//
//  Created by Joe Maghzal on 03/05/2024.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ElementaryUIMacros)
import ElementaryUIMacros

final class HexColorMacroTests: XCTestCase {
// MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "color": HexColorMacro.self,
    ]

// MARK: - Tests
    func testMacroColorWithoutHashtag() {
        assertMacroExpansion(
            """
            #color("676C60")
            """,
            expandedSource: """
            Color(
                red: 103.0 / 255,
                green: 108.0 / 255,
                blue: 96.0 / 255,
                opacity: 255.0 / 255
            )
            """,
            macros: testMacros
        )
    }
    
    func testMacroColorWithHashtag() {
        assertMacroExpansion(
            """
            #color("#676C60")
            """,
            expandedSource: """
            Color(
                red: 103.0 / 255,
                green: 108.0 / 255,
                blue: 96.0 / 255,
                opacity: 255.0 / 255
            )
            """,
            macros: testMacros
        )
    }
    
    func testMacroColorWithOpacity() {
        assertMacroExpansion(
            """
            #color("#676C6080")
            """,
            expandedSource: """
            Color(
                red: 103.0 / 255,
                green: 108.0 / 255,
                blue: 96.0 / 255,
                opacity: 128.0 / 255
            )
            """,
            macros: testMacros
        )
    }
}
#endif
