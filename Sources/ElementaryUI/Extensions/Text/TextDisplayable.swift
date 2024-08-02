//
//  TextDisplayable.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// Requirements for defining objects that can display text content.
///
/// ```swift
/// enum PrefrencesKey: LocalizedStringKey, TextDisplayable {
///     case profile, language
///     var content: TextContentType {
///         return .localized(key: rawValue, bundle: .module)
///     }
/// }
/// ```
public protocol TextDisplayable {
    /// The text content to be displayed.
    var content: TextContentType { get }
}

/// The types of text content that can be displayed.
public enum TextContentType {
    /// Text content localized using a key from a specific bundle.
    case localized(key: LocalizedStringKey, bundle: Bundle?)
    
    /// Unlocalized text content represented by a string.
    case unlocalized(String)
}

// MARK: - TextDisplayable
extension TextContentType: TextDisplayable {
    /// The text content to be displayed.
    public var content: TextContentType {
        return self
    }
}
