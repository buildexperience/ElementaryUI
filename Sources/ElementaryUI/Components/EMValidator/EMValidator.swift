//
//  EMValidator.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import Foundation

/// Requirements for defining validation rules for input values.
///
/// Conform to this protocol to create custom validators that can be used to validate user input.
///
/// ```swift
/// struct PasswordValidator: EMValidator {
///     func validate(_ value: String) -> Bool? {
///         // Validate the password here.
///     }
/// }
/// ```
public protocol EMValidator<Value> {
    /// The type of value to be validated.
    associatedtype Value
    
    /// Validates the provided value.
    ///
    /// - Parameter value: The value to be validated.
    /// - Returns: `true` if the value is valid, `false` otherwise. Returns `nil` if validation cannot be determined.
    func validate(_ value: Value) -> Bool?
}
