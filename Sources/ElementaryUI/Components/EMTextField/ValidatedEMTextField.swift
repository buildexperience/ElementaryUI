//
//  ValidatedEMTextField.swift
//
//
//  Created by Joe Maghzal on 02/05/2024.
//

import SwiftUI

extension EMTextField {
    /// ``ViewModifier`` for validating the input of an ``EMTextField``.
    ///
    /// This modifier allows handling text changes and validation based on the provided configuration by the text field.
    /// 
    /// - Warning: This is an internal modifier not meant to be used outside of ``EMTextField``.
    struct ValidationViewModifier: ViewModifier {
        /// The binding value to the text input.
        @Binding var text: String
        
        /// The binding value tracking the validation state of the text field.
        @Binding var validation: Bool?
        
        /// The validation configurations for the text field.
        let configuration: ValidationConfiguration
        
        /// The body of the ``ViewModifier``.
        func body(content: Content) -> some View {
            content
                .onChange(of: text) {
                    if case .onSubmit(let clearOnChange) = configuration.validationTrigger, clearOnChange {
                        clear()
                    }else if case .onChange = configuration.validationTrigger {
                        validate()
                    }
                }.onSubmit {
                    guard case .onSubmit = configuration.validationTrigger else {return}
                    validate()
                }
        }
    }
}

//MARK: - Private Functions
extension EMTextField.ValidationViewModifier {
    /// Validates the text input based on the configured validator.
    private func validate() {
        let validationResult = configuration.validator.validate(text)
        validation = validationResult
        configuration.onValidation?(validationResult)
    }
    
    /// Clears the validation state of the text field.
    private func clear() {
        validation = nil
        configuration.onValidation?(nil)
    }
}
