//
//  EMTextDisplayable.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// Requirements for defining objects that can display text content.
///
/// ```swift
/// enum PrefrencesKey: LocalizedStringKey, EMTextDisplayable {
///     case profile, language
///     var content: EMTextContentType {
///         return .localized(key: rawValue, bundle: .module)
///     }
/// }
/// ```
///
public protocol EMTextDisplayable {
    /// The text content to be displayed.
    var content: EMTextContentType { get }
}

/// The types of text content that can be displayed.
public enum EMTextContentType {
    /// Text content localized using a key from a specific bundle.
    case localized(key: LocalizedStringKey, bundle: Bundle?)
    
    /// Unlocalized text content represented by a string.
    case unlocalized(String)
}
