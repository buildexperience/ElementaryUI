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

let testMacros: [String: Macro.Type] = [
    "color": HexColorMacro.self,
]

final class HexColorMacroTests: XCTestCase {
    func testMacroColorWithoutHashtag() throws {
        assertMacroExpansion(
            """
            #color("676C60")
            """,
            expandedSource: """
            Color(red: 103 / 255, green: 108 / 255, blue: 96 / 255, opacity: 255 / 255)
            """,
            macros: testMacros
        )
    }
    func testMacroColorWithHashtag() throws {
        assertMacroExpansion(
            """
            #color("#676C60")
            """,
            expandedSource: """
            Color(red: 103 / 255, green: 108 / 255, blue: 96 / 255, opacity: 255 / 255)
            """,
            macros: testMacros
        )
    }
    func testMacroColorWithOpacity() throws {
        assertMacroExpansion(
            """
            #color("#676C6080")
            """,
            expandedSource: """
            Color(red: 103 / 255, green: 108 / 255, blue: 96 / 255, opacity: 128 / 255)
            """,
            macros: testMacros
        )
    }
}
#endif