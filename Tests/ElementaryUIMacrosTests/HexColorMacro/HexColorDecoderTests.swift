//
//  HexColorDecoderTests.swift
//
//
//  Created by Joe Maghzal on 04/05/2024.
//

import Foundation
import XCTest

#if canImport(ElementaryUIMacros)
import ElementaryUIMacros

final class HexColorDecoderTests: XCTestCase {
//MARK: - Properties
    typealias Components = HexColorDecoder.ColorComponents
    
//MARK: - Hashtag Validation Tests
    func testDecoderSucceedsWithoutHashtag() {
        let hex = "ffffff"
        XCTAssertNoThrow(try HexColorDecoder.decode(hex).get())
    }
    func testDecoderSucceedsWhenHashtagIsThePrefix() {
        let hex = "#ffffff"
        XCTAssertNoThrow(try HexColorDecoder.decode(hex).get())
    }
    func testDecoderFailsWhenHashtagIsNotThePrefix() {
        let hexs = [
            "f#ffff",
            "ff#fff",
            "fff#ff",
            "ffff#f",
            "fffff#",
        ]
        for hex in hexs {
            XCTAssertThrowsError(try HexColorDecoder.decode(hex).get())
        }
    }
    
//MARK: - Characters Validation Tests
    func testDecoderFailsWhenHexContainsInvalidCharacters() {
        let hexs = [
            "qwgrty",
            ":;[]{}",
            "()$%*&",
        ]
        for hex in hexs {
            XCTAssertThrowsError(try HexColorDecoder.decode(hex).get()) { error in
                let error = error as? HexColorMacroError
                let characters = Array(hex)
                XCTAssertEqual(error, .invalidCharacters(hex: hex, characters: characters))
            }
        }
    }
    func testDecoderSucceedsWhenHexIsValid() {
        let hexs = [
            "123456",
            "abcdef",
            "135ace",
        ]
        for hex in hexs {
            XCTAssertNoThrow(try HexColorDecoder.decode(hex).get())
        }
    }
    
//MARK: - Length Validation Tests
    func testDecoderFailsWhenHexLengthIsInvalid() {
        for i in 0...10 {
            guard i != 6 && i != 8 else {
                continue
            }
            let hex = Array(repeating: "f", count: i).joined()
            XCTAssertThrowsError(try HexColorDecoder.decode(hex).get()) { error in
                let error = error as? HexColorMacroError
                XCTAssertEqual(error, .invalidLength(hex: hex))
            }
        }
    }
    func testDecoderSucceedsWhenHexLengthIsValid() {
        let hexs = [
            "ffffff",
            "ffffffff"
        ]
        for hex in hexs {
            XCTAssertNoThrow(try HexColorDecoder.decode(hex).get())
        }
    }
    
//MARK: - 6 Digits Components Tests
    func testDecoderWith6DigitsHexRedComponent() throws {
        for hex in SixDigits.redHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.red, 128)
        }
    }
    func testDecoderWith6DigitsHexGreenComponent() throws {
        for hex in SixDigits.greenHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.green, 128)
        }
    }
    func testDecoderWith6DigitsHexBlueComponent() throws {
        for hex in SixDigits.blueHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.blue, 128)
        }
    }
    func testDecoderWith6DigitsHexOpacityComponent() throws {
        let hexsArray = [
            SixDigits.redHexs,
            SixDigits.greenHexs,
            SixDigits.blueHexs
        ]
        for hexs in hexsArray {
            for hex in hexs {
                let components = try HexColorDecoder.decode(hex).get()
                XCTAssertEqual(components.opacity, 255)
            }
        }
    }
    
//MARK: - 8 Digits Components Tests
    func testDecoderWith8DigitsHexRedComponent() throws {
        for hex in EightDigits.redHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.red, 128)
        }
    }
    func testDecoderWith8DigitsHexGreenComponent() throws {
        for hex in EightDigits.greenHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.green, 128)
        }
    }
    func testDecoderWith8DigitsHexBlueComponent() throws {
        for hex in EightDigits.blueHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.blue, 128)
        }
    }
    func testDecoderWith8DigitsHexOpacityComponent() throws {
        for hex in EightDigits.opacityHexs {
            let components = try HexColorDecoder.decode(hex).get()
            XCTAssertEqual(components.opacity, 128)
        }
    }
}

//MARK: - SixDigits
extension HexColorDecoderTests {
    enum SixDigits {
        static let redHexs = [
            "800000",
            "80ff00",
            "80ffff"
        ]
        static let greenHexs = [
            "008000",
            "ff8000",
            "ff80ff"
        ]
        static let blueHexs = [
            "000080",
            "00ff80",
            "ffff80"
        ]
    }
}

//MARK: - EightDigits
extension HexColorDecoderTests {
    enum EightDigits {
        static let redHexs = [
            "80000000",
            "80ff0000",
            "80ffff00",
            "80ffffff",
        ]
        static let greenHexs = [
            "00800000",
            "ff800000",
            "ff80ff00",
            "ff80ffff",
        ]
        static let blueHexs = [
            "00008000",
            "00ff8000",
            "ffff8000",
            "ffff80ff",
        ]
        static let opacityHexs = [
            "00000080",
            "0000ff80",
            "00ffff80",
            "ffffff80",
        ]
    }
}
#endif
