//
//  Color.swift
//  
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI

public extension Color {
    /// Creates a ``Color`` from a hexadecimal string representation.
    ///
    /// The hex string can include an optional alpha component in addition to the red, green, and blue components.
    ///
    /// Supported hex formats:
    /// - 6-character format: "#RRGGBB"
    /// - 8-character format: "#RRGGBBAA" (with alpha component)
    ///
    /// ```swift
    /// let redColor = Color(hex: "#FF0000") // Creates a red color
    ///
    /// let redColor = Color(hex: "#FF000080") // Creates a red color with an opacity of 0.5
    /// ```
    ///
    /// - Parameter hex: A hexadecimal string representing the color.
    /// - Note: If the hexadecimal string is invalid or cannot be parsed, the initializer defaults to a white color with full opacity.
    ///
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.count == 6 {
            hex += "ff"
        }
        let scanner = Scanner(string: hex)
        var number = UInt64.zero
        guard scanner.scanHexInt64(&number) else {
            self.init(.white)
            return
        }
        let red = Double((number & 0xff000000) >> 24) / 255
        let green = Double((number & 0x00ff0000) >> 16) / 255
        let blue = Double((number & 0x0000ff00) >> 8) / 255
        let opacity = Double(number & 0x000000ff) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

#Preview {
    VStack {
        Color(hex: "ffe700")
        Color(hex: "ff000080")
    }
}
