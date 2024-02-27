//
//  v.swift
//
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// An enumeration representing different styling attributes for text.
public enum StylingAttibute: Int, Hashable, Equatable, Sendable, CaseIterable {
    ///The default color used for texts.
    case primaryText
    ///The default color used for placeholders.
    case placeholderText
}

/// A utility struct for managing styling attributes.
public struct Styling {
//MARK: - Singleton
    /// The shared instance of the Styling struct.
    static var shared = Styling()
//MARK: - Properties
    /// A dictionary containing styling attributes and their corresponding colors.
    private var attributes: [StylingAttibute: Color] = [
        .primaryText: .primary,
        .placeholderText: .secondary
    ]
}

//MARK: - Public Functions
public extension Styling {
    /// Sets the styling attributes with the provided colors.
    ///
    /// ```swift
    /// Styling.set(attributes: [
    ///     .primaryText: Color.red
    /// ])
    /// ```
    ///
    /// - Parameter attributes: A dictionary containing styling attributes and their corresponding colors.
    static func set(attributes: [StylingAttibute: Color]) {
        shared.attributes.merge(attributes) { currentValue, newValue in
            return newValue
        }
    }
}

//MARK: - Internal Functions
extension Styling {
    /// Returns the color associated with the specified styling attribute.
    ///
    /// ```swift
    /// Styling.style(for: .primaryText)
    /// ```
    ///
    /// - Parameter attribute: The styling attribute.
    /// - Returns: The color associated with the specified styling attribute, or a default color if not found.
    static func style(for attribute: StylingAttibute) -> Color {
        let attribute = shared.attributes[attribute]
        return attribute ?? Color.red
    }
}
