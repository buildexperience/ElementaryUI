//
//  EMText.swift
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
/// EMText("Hello, World!")
///     .font(.title)
///     .foregroundStyle(Color.red)
/// ```
///
/// - Displaying a localized string using a bundle:
///
/// ```swift
/// EMText("Hello, World!", bundle: .module)
///     .font(.title)
///     .foregroundStyle(Color.red)
/// ```
///
public struct EMText: View {
    /// The content type of the text, either localized or unlocalized.
    private let string: EMTextContentType
    public var body: some View {
        text()
    }
}

//MARK: - Public Functions
public extension EMText {
    /// Get the ``Text`` view used to display the content.
    ///
    /// - Returns: The underlying ``Text`` view representing the content specified by the `string` property.
    ///
    func text() -> Text {
        switch string {
            case .localized(let localizedStringKey, let bundle):
                return Text(localizedStringKey, bundle: bundle)
            case .unlocalized(let string):
                return Text(string)
        }
    }
}

//MARK: - Initializers
public extension EMText {
    /// Creates a text view that displays an `EMTextDisplayable`.
    ///
    /// - Parameter text: The content of the text to be displayed.
    ///
    init<T: EMTextDisplayable>(_ text: T) {
        self.string = text.content
    }
    
    /// Creates a text view that displays a stored string without localization.
    ///
    /// ```swift
    /// EMText("Hello, World!")
    /// ```
    ///
    /// - Parameter content: The unlocalized text content represented by a string.
    ///
    init<S: StringProtocol>(_ content: S) {
        self.string = .unlocalized(String(content))
    }
    
    /// Creates a text view that displays localized content identified by a key.
    ///
    /// ```swift
    /// EMText("Hello!", bundle: .module)
    /// ```
    ///
    /// - Parameters:
    ///   - key: The key for the localized text content.
    ///   - bundle: The bundle containing the localized string resources. If `nil`, the main bundle is used.
    ///
    init(_ key: LocalizedStringKey, bundle: Bundle? = nil) {
        self.string = .localized(key: key, bundle: bundle)
    }
    
    /// Creates a text view that displays either a localized string identified by a key, or a stored string without localization.
    ///
    /// ```swift
    /// EMText(.unlocalized("Hello!"))
    /// ```
    ///
    /// - Parameter string: The content of the text to be displayed.
    ///
    init(_ string: EMTextContentType) {
        self.string = string
    }
}

#Preview {
    EMText("Hello, World!")
        .font(Font.title)
        .foregroundStyle(Color.red)
}
