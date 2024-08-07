//
//  HexColorMacro.swift
//
//
//  Created by Joe Maghzal on 04/05/2024.
//

import SwiftUI

/// Macro for expanding hexadecimal color strings into `SwiftUI` ``Color`` expressions.
///
/// This macro enables the expansion of hexadecimal color strings into ``Color`` expressions. It abstracts away the conversion
///  process & provides a convenient way to include colors in Swift code using hexadecimal notation with compiler validations.
///
/// **Supported validations:**
///  - **Length**: The following error will be thrown when the length of the provided hex is invalid: 
///  `The hex "123456789" must be exactly 6 or 8 characters long`.
///
///  - **Characters**: The following error will be thrown when the provided hex contains invalid characters: 
///  `The hex "LKJHG9" contains invalid characters: L, K, J, H, G`.
///
///  - **Decoding Failure**: The following error will be thrown when the provided hex could not be decoded: 
///  `The hex "999999" could not be decoded`.
///
/// **Supported hex formats:**
///  - 6 digits, the opacity component will always be 1:
///  ```swift
///  #color("ff0000") // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 255 / 255)
///  ```
///  - 8 digits, decodes the opacity component:
///  ```swift
///  #color("ff000080") // Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255, opacity: 128 / 255)
///  ```
///
/// - Note: Adding the '#' is optional & won't affect the decoding proccess.
@freestanding(expression)
public macro color(
    _ hex: StringLiteralType
) -> Color = #externalMacro(
    module: "ElementaryUIMacros",
    type: "HexColorMacro"
)
