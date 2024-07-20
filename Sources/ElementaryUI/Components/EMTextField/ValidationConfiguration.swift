//
//  ValidationConfiguration.swift
//  
//
//  Created by Joe Maghzal on 02/05/2024.
//

import Foundation

/// Validation configurations for an`` EMTextField``.
internal struct ValidationConfiguration {
    /// The validator used for validating the text input.
    internal let validator: any EMTextFieldValidator
    
    /// The type of trigger needed for the validation to be performed.
    internal let validationTrigger: ValidationTrigger
    
    /// An optional callback closure to be executed after validation.
    internal let onValidation: ((_ validation: Bool?) -> Void)?
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
