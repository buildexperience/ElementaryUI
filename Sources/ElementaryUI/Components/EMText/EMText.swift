//
//  NJText.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// A wrapper arround ``Text`` that displays one or more lines of read-only text.
///
/// - Displaying a string without localization or a ``LocalizedStringKey``:
///
/// ```swift
/// NJText("Hello, World!")
///     .font(.title)
///     .foregroundStyle(Color.red)
/// ```
///
/// - Displaying a localized string using a bundle:
///
/// ```swift
/// NJText("Hello, World!", bundle: .module)
///     .font(.title)
///     .foregroundStyle(Color.red)
/// ```
///
public struct NJText<Style: ShapeStyle>: View {
//MARK: - Properties
    /// The environment value representing the current font.
    @Environment(\.font) private var font
    
    /// The environment value representing the current foregroundStyle.
    @Environment(\.foregroundStyle) private var foregroundStyle
    
    /// The content type of the text, either localized or unlocalized.
    private let string: NJTextContentType
//MARK: - Body
    public var body: some View {
        text()
    }
    /// Returns a ``Text`` view representing the content specified by the `string` property.
    private var textBody: Text {
        switch string {
            case .localized(let localizedStringKey, let bundle):
                return Text(localizedStringKey, bundle: bundle)
            case .unlocalized(let string):
                return Text(string)
        }
    }
}

//MARK: - Public Functions
public extension NJText {
    /// Get the ``Text`` view used to display the content.
    ///
    /// - Returns: The underlying ``Text`` view used by the wrapper.
    ///
    func text() -> Text {
        textBody
            .foregroundStyle(foregroundStyle)
            .font(font)
    }
}

//MARK: - Initializers
public extension NJText where Style == Color {
    /// Creates a text view that displays an `NJTextDisplayable`.
    ///
    /// - Parameter text: The content of the text to be displayed.
    ///
    init<T: NJTextDisplayable>(_ text: T) {
        self.string = text.content
    }
    
    /// Creates a text view that displays a stored string without localization.
    ///
    /// ```swift
    /// NJText("Hello, World!")
    /// ```
    ///
    /// - Parameter content: The unlocalized text content represented by a string.
    ///
    init<S: StringProtocol>(_ content: S) {
        self.string = .unlocalized(string: String(content))
    }
    
    /// Creates a text view that displays localized content identified by a key.
    ///
    /// ```swift
    /// NJText("Hello!", bundle: .module)
    /// ```
    ///
    /// - Parameters:
    ///   - key: The key for the localized text content.
    ///   - bundle: The bundle containing the localized string resources. If `nil`, the main bundle is used.
    ///
    init(_ key: LocalizedStringKey, bundle: Bundle? = nil) {
        self.string = .localized(key: key, bundle: bundle)
    }
}

#Preview {
    NJText("Hello, World!")
        .font(Font.title)
        .foregroundStyle(Color.red)
}
