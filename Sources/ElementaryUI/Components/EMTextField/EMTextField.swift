//
//  EMTextField.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// Specialized ``EMValidator`` for ``EMTextField``.
public typealias EMTextFieldValidator = EMValidator<String>

/// Styllable wrapper arround ``TextField`` that displays an editable text interface.
///
/// ``EMTextField`` provides a flexible way to create text fields with various placeholder types, bindings, and prompts. It supports validation through the ``validator(_:_:validation:_:)`` modifier, allowing you to apply custom validators and define validation triggers.
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
/// You can create custom styles using ``EMTextFieldStyle``:
///
/// ```swift
/// struct ClearableEMTextFieldStyle: EMTextFieldStyle {
///     func makeBody(configuration: Configuration) -> some View {
///         HStack {
///             configuration.content
///             Button(action: {
///                 configuration.text.wrappedValue = "" // Clear the text field
///             }) {
///                 Text("Clear")
///             }
///         }
///     }
/// }
/// ```
///
/// And apply them to the text field using ``emTextFieldStyle(_:)``.
///
/// ```swift
/// EMTextField("Enter your email", text: $email)
///     .emTextFieldStyle(ClearableEMTextFieldStyle())
/// ```
///
/// - Note: The applied style will be propagated through the environment.
public struct EMTextField: View {
    /// The current style for the text field.
    @Environment(\.emTextFieldStyle) private var style
    
    /// The binding to the text value of the text field.
    @Binding private var text: String
    
    /// The binding to the validation state of the text field.
    @Binding private var validation: Bool?
    
    /// The prompt ``Text`` to be displayed for the text field.
    private let prompt: Text?
    
    /// The placeholder content type for the text field.
    private let placeholder: TextContentType
    
    /// The configuration for validation of the text field.
    private let validationConfiguration: ValidationConfiguration?
    
    /// The configuration of the text field used by the current style.
    private var configuration: EMTextFieldConfiguration {
        let content = AnyView(textField)
        return EMTextFieldConfiguration(content: content, text: $text, validation: validation)
    }
    
    /// The internal representation of the text field.
    private var textField: some View {
        Group {
            switch placeholder {
                case .localized(let key, _):
                    TextField(key, text: $text, prompt: prompt)
                case .unlocalized(let string):
                    TextField(string, text: $text, prompt: prompt)
            }
        }.if(let: validationConfiguration) { content, value in
            content
                .modifier(ValidationViewModifier(text: $text, validation: $validation, configuration: value))
        }
    }
    
    /// The body of the ``View``.
    public var body: some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}

//MARK: - TextDisplayable Initializers
extension EMTextField {
    /// Creates a text field with a text label that can be generated from a localized title string or from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    public init(_ placeholder: TextDisplayable = TextContentType.unlocalized(""), text: Binding<String>, prompt: Text? = nil) {
        self._text = text
        self._validation = .constant(nil)
        self.prompt = prompt
        self.placeholder = placeholder.content
        self.validationConfiguration = nil
    }
    
    /// Creates a text field with a text label that can be generated from a localized title string or from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init(_ placeholder: TextDisplayable = TextContentType.unlocalized(""), text: Binding<String>, @ViewBuilder prompt: () -> Text?) {
        self.init(placeholder, text: text, prompt: prompt())
    }
}

//MARK: - LocalizedStringKey Initializers
extension EMTextField {
    /// Creates a text field with a text label that can be generated from a localized title string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init(_ placeholder: LocalizedStringKey = "", text: Binding<String>, prompt: Text? = nil) {
        self.init(
            TextContentType.localized(key: placeholder, bundle: nil),
            text: text,
            prompt: prompt
        )
    }
    
    /// Creates a text field with a text label that can be generated from a localized title string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init(_ placeholder: LocalizedStringKey = "", text: Binding<String>, @ViewBuilder prompt: () -> Text?) {
        self.init(placeholder, text: text, prompt: prompt())
    }
}

//MARK: - StringProtocol Initializers
extension EMTextField {
    /// Creates a text field with a text label that can be generated from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init<S: StringProtocol>(_ placeholder: S = "", text: Binding<String>, prompt: Text? = nil) {
        self.init(
            TextContentType.unlocalized(String(placeholder)),
            text: text,
            prompt: prompt
        )
    }
    
    /// Creates a text field with a text label that can be generated from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display and edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init<S: StringProtocol>(_ placeholder: S = "", text: Binding<String>, @ViewBuilder prompt: () -> Text?) {
        self.init(placeholder, text: text, prompt: prompt())
    }
}

//MARK: - Modifiers
public extension EMTextField {
    /// Applies a validator to the text field with the specified validation type and optional callback.
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
    func validator<Validator: EMTextFieldValidator>(
        _ validator: Validator,
        _ trigger: ValidationTrigger,
        validation: Binding<Bool?> = .constant(nil),
        _ onValidation: ((Bool?) -> Void)? = nil
    ) -> some View {
        let validationConfiguration = ValidationConfiguration(validator: validator, validationTrigger: trigger, onValidation: onValidation)
        return EMTextField(text: $text, validation: $validation, prompt: prompt, placeholder: placeholder, validationConfiguration: validationConfiguration)
    }
}
