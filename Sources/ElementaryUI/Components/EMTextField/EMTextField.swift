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
/// ``EMTextField`` provides a flexible way to create text fields with various placeholder types, bindings, & prompts. It supports validation through the ``validator(_:_:validation:_:)`` modifier, allowing you to apply custom validators & define validation triggers.
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
@Stylable(environmentKey: "emTextFieldStyle")
public struct EMTextField: View {
    /// The current style for the text field.
    @Environment(\.emTextFieldStyle) private var style
    
    /// The binding to the text value of the text field.
    @Binding private var text: String
    
    /// The prompt ``Text`` to be displayed for the text field.
    private let prompt: Text?
    
    /// The placeholder content type for the text field.
    private let placeholder: TextContentType
    
    /// The configuration of the text field used by the current style.
    private var configuration: EMTextFieldConfiguration {
        return EMTextFieldConfiguration(text: $text, validation: nil)
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
        }
    }
    
    /// The body of the ``View``.
    public var body: some View {
        VStack {
            AnyView(
                style.makeBody(
                    content: AnyView(textField),
                    configuration: configuration
                )
            ).environment(\.emTextFieldStyle, .default)
        }
    }
}

//MARK: - TextDisplayable Initializers
extension EMTextField {
    /// Creates a text field with a text label that can be generated from a localized title string or from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display & edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    public init(_ placeholder: TextDisplayable = TextContentType.unlocalized(""), text: Binding<String>, prompt: Text? = nil) {
        self._text = text
        self.prompt = prompt
        self.placeholder = placeholder.content
    }
    
    /// Creates a text field with a text label that can be generated from a localized title string or from an unlocalized string.
    ///
    /// - Parameters:
    ///   - placeholder: The content of the text field, describing its purpose.
    ///   - text: The text to display & edit.
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
    ///   - text: The text to display & edit.
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
    ///   - text: The text to display & edit.
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
    ///   - text: The text to display & edit.
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
    ///   - text: The text to display & edit.
    ///   - prompt: A ``Text`` representing the prompt of the text field which provides users with guidance on what to type into the text  field.
    @inlinable
    public init<S: StringProtocol>(_ placeholder: S = "", text: Binding<String>, @ViewBuilder prompt: () -> Text?) {
        self.init(placeholder, text: text, prompt: prompt())
    }
}
