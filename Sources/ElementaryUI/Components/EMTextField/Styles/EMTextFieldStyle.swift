//
//  EMTextFieldStyle.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// Requirements for defining custom styles for ``EMTextField``.
///
/// Implement this protocol to define a custom style for ``EMTextField`` to its appearance and behavior.
///
/// ```swift
/// struct CustomTextFieldStyle: EMTextFieldStyle {
///     func makeBody(configuration: Configuration) -> some View {
///         // Customize the appearance and behavior of the text field here
///         configuration.content
///     }
/// }
/// ```
public protocol EMTextFieldStyle {
    /// The properties of a text field.
    typealias Configuration = EMTextFieldConfiguration
    
    /// A view that represents the body of a text field.
    associatedtype Body: View
    
    /// Creates a view that represents the body of a text field.
    ///
    /// The system calls this method for each ``EMTextField`` instance in a view hierarchy where this style is the current text field style.
    ///
    /// - Parameter configuration : The properties of the text field.
    /// - Returns: A view that represents the body of a text field.
    @ViewBuilder @MainActor func makeBody(configuration: Configuration) -> Body
}

/// Configurations for ``EMTextField`` used in an ``EMTextFieldStyle``.
public struct EMTextFieldConfiguration {
    /// The unmodified content view of the text field.
    public let content: AnyView
    
    /// The binding to the text value of the text field.
    public let text: Binding<String>
    
    /// The validation state of the text field.
    public let validation: Bool?
}
