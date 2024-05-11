//
//  Color.swift
//  
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI

extension Color {
    /// Creates a ``Color`` from a hexadecimal string representation.
    ///
    /// The hex string can include an optional alpha component in addition to the red, green, and blue components.
    ///
    /// **Supported hex formats:**
    ///  - 6 digits, the opacity component will always be 1:
    ///  ```swift
    ///  Color(hex: "ff0000") 
    ///  // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 255 / 255)
    ///  ```
    ///  - 8 digits, decodes the opacity component:
    ///  ```swift
    ///  Color(hex: "ff000080") 
    ///  // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 128 / 255)
    ///  ```
    ///
    /// - Parameter hex: A hexadecimal string representing the color.
    /// - Note: Adding the '#' is optional & won't affect the decoding proccess.
    /// - Warning: If the hexadecimal string is invalid or cannot be parsed, the initializer defaults to a white color with full opacity.
    public init(hex: String) {
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
