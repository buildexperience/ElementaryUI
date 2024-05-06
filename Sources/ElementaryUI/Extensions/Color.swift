//
//  Color.swift
//  
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI
import ElementaryUIMacros

public extension Color {
    /// Creates a ``Color`` from a hexadecimal string representation.
    ///
    /// The hex string can include an optional alpha component in addition to the red, green, and blue components.
    ///
    /// **Supported hex formats:**
    ///  - 6 digits, the opacity component will always be 1:
    ///  ```swift
    ///  Color(hex: "ff0000") // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 255 / 255)
    ///  ```
    ///  - 8 digits, decodes the opacity component:
    ///  ```swift
    ///  Color(hex: "ff000080") // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 128 / 255)
    ///  ```
    ///
    /// - Parameter hex: A hexadecimal string representing the color.
    /// - Note: Adding the '#' is optional & won't affect the decoding proccess.
    /// - Warning: If the hexadecimal string is invalid or cannot be parsed, the initializer defaults to a white color with full opacity.
    init(hex: String) {
        let decodingResult = HexColorDecoder.decode(hex)
        switch decodingResult {
            case .success((let red, let green, let blue, let opacity)):
                self.init(.sRGB, red: Double(red / 255), green: Double(green / 255), blue: Double(blue / 255), opacity: Double(opacity / 255))
                
            case .failure:
                self = .white
        }
    }
}
