//
//  NJTextDisplayable.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// Protocol for objects that can display text content.
///
/// Conforming types must provide a `content` property representing the text content to be displayed.
///
/// ```swift
/// enum PrefrencesKey: LocalizedStringKey, NJTextDisplayable {
///     case profile, language
///     var content: NJTextContentType {
///         return .localized(key: rawValue, bundle: .module)
///     }
/// }
/// ```
///
public protocol NJTextDisplayable {
    /// The text content to be displayed.
    var content: NJTextContentType { get }
}

/// The types of text content that can be displayed.
public enum NJTextContentType {
    /// Text content localized using a key from a specific bundle.
    case localized(key: LocalizedStringKey, bundle: Bundle?)
    
    /// Unlocalized text content represented by a string.
    case unlocalized(string: String)
}
