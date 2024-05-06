//
//  ValidationConfiguration.swift
//  
//
//  Created by Joe Maghzal on 02/05/2024.
//

import Foundation

/// Validation configurations for an`` EMTextField``.
struct ValidationConfiguration {
    /// The validator used for validating the text input.
    let validator: any EMTextFieldValidator
    
    /// The type of trigger needed for the validation to be performed.
    let validationTrigger: ValidationTrigger
    
    /// An optional callback closure to be executed after validation.
    let onValidation: ((Bool?) -> Void)?
}

/// Types of validation triggers for an`` EMTextField``.
public enum ValidationTrigger {
    /// Performs validation when the text changes.
    case onChange
    
    /// Performs validation when the user presses return on the keyboard.
    ///
    /// - Parameter clearOnChange: A Boolean value indicating whether to clear the validation when the text changes, defaults to true.
    case onSubmit(clearOnChange: Bool = true)
}
