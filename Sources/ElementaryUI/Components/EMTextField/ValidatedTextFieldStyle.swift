//
//  ValidatedTextFieldStyle.swift
//
//
//  Created by Joe Maghzal on 02/05/2024.
//

import SwiftUI

public struct ValidatedTextFieldStyle {
    /// The binding value tracking the validation state of the text field.
    @Binding private var validation: Bool?
    
    /// The validation configurations for the text field.
    private let validationConfiguration: ValidationConfiguration
}

// MARK: - EMTextFieldStyle
extension ValidatedTextFieldStyle: EMTextFieldStyle {
    public func makeBody(
        content: Content,
        configuration: Configuration
    ) -> some View {
        let text = configuration.text.wrappedValue
        content
            .onChange(of: text) { newValue in
                if case .onSubmit(let clearOnChange) = validationConfiguration.validationTrigger, clearOnChange {
                    clear()
                }else if case .onChange = validationConfiguration.validationTrigger {
                    validate(text: newValue)
                }
            }.onSubmit {
                guard case .onSubmit = validationConfiguration.validationTrigger else {return}
                validate(text: text)
            }
    }
}

// MARK: - Initializer
extension ValidatedTextFieldStyle {
    public init(
        validation: Binding<Bool?> = .constant(nil),
        validator: any EMTextFieldValidator,
        validationTrigger: ValidationTrigger,
        onValidation: ((_ validation: Bool?) -> Void)? = nil
    ) {
        self._validation = validation
        self.validationConfiguration = ValidationConfiguration(
            validator: validator,
            validationTrigger: validationTrigger,
            onValidation: onValidation
        )
    }
}

// MARK: - Private Functions
extension ValidatedTextFieldStyle {
    /// Validates the text input based on the configured validator.
    private func validate(text: String) {
        let validationResult = validationConfiguration.validator.validate(text)
        validation = validationResult
        validationConfiguration.onValidation?(validationResult)
    }
    
    /// Clears the validation state of the text field.
    private func clear() {
        validation = nil
        validationConfiguration.onValidation?(nil)
    }
}

// MARK: - Modifiers
extension EMTextField {
    /// Applies a validator to the text field with the specified validation type & optional callback.
    ///
    /// The validation can be accessed by callback & / or binding.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var emailValid: Bool?
    ///     @State private var email = ""
    ///     private var color: Color {
    ///         guard let validation else {
    ///             return .primary
    ///         }
    ///         return validation ? .green: .red
    ///     }
    ///     var body: some View {
    ///         VStack {
    ///             EMTextField("Enter your email", text: $email)
    ///                 .validator(.email, .onSubmit, validation: $emailValid) { validation in
    ///                     print(validation) // You can use the validation callback instead of using an onChange modifier with emailValid
    ///                 }.foregroundStyle(color)
    ///             Button(action: {
    ///                 emailValid = nil // Reset the validation.
    ///             }) {
    ///                 Text("Reset")
    ///             }
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - validator: The validator to be applied to the text field.
    ///   - type: The validation type to be performed.
    ///   - validation: The optional binding to track or modifiy the validation state of the text field.
    ///   - onValidation: An optional callback to be executed after validation.
    ///
    /// - Returns: A modified version of the text field with the applied validator.
    ///
    /// - Note: The validation result will be passed to the text field's style.
    public func validator<Validator: EMTextFieldValidator>(
        _ validator: Validator,
        _ trigger: ValidationTrigger,
        validation: Binding<Bool?> = .constant(nil),
        _ onValidation: ((_ validation: Bool?) -> Void)? = nil
    ) -> some View {
        let style = ValidatedTextFieldStyle(
            validation: validation,
            validator: validator,
            validationTrigger: trigger,
            onValidation: onValidation
        )
        return emTextFieldStyle(style)
    }
}
