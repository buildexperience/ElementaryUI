//
//  NJText.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

/// A view that displays one or more lines of read-only text.
///
/// ```swift
/// NJText("Hello, World!")
///     .font(Font.title, weight: .bold)
///     .foregroundStyle(Color.red)
/// ```
///
public struct NJText<Style: ShapeStyle>: View {
//MARK: - Properties
    private let string: NJTextContentType
    private let font: Font?
    private let style: Style
//MARK: - Body
    public var body: some View {
        text()
    }
    private var textBody: Text {
        switch string {
            case .localized(let localizedStringKey, let bundle):
                return Text(localizedStringKey, bundle: bundle)
            case .unlocalized(let string):
                return Text(string)
        }
    }
    public func text() -> Text {
        textBody
            .foregroundStyle(style)
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
        self.font = nil
        self.style = Styling.style(for: .primaryText)
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
        self.font = nil
        self.style = Styling.style(for: .primaryText)
    }
    
    /// Creates a text view that displays localized content identified by a key.
    ///
    /// ```swift
    /// NJText("Hello!", bundle: .module)
    /// ```
    ///
    /// - Parameters:
    ///  - key: The key for the localized text content.
    ///  - bundle: The bundle containing the localized string resources. If `nil`, the main bundle is used.
    ///
    init(_ key: LocalizedStringKey, bundle: Bundle? = nil) {
        self.string = .localized(key: key, bundle: bundle)
        self.font = nil
        self.style = Styling.style(for: .primaryText)
    }
}

//MARK: - Modifiers
public extension NJText {
    /// Applies a foreground style to the text.
    ///
    /// ```swift
    /// NJText("Hello, World!")
    ///     .foregroundStyle(Color.red)
    /// ```
    ///
    /// - Parameter style: The style to be applied to the text.
    /// - Returns: An `NJText` view with the specified foreground style.
    ///
    func foregroundStyle<S: ShapeStyle>(_ style: S) -> NJText<S> {
        return NJText<S>(string: string, font: font, style: style)
    }
    
    /// Applies a custom font to the text.
    ///
    /// ```swift
    /// NJText("Hello, World!")
    ///     .font(Font.title, weight: .bold)
    /// ```
    ///
    /// - Parameters:
    ///  - font: The custom font to be applied to the text.
    ///  - weight: The custom weight to be applied to the font. If `nil`, the default weight is used.
    ///
    /// - Returns: An NJText view with the specified font.
    ///
    func font<F: NJFont>(_ font: F?, weight: F.Weight? = nil) -> NJText {
        //TODO: - Migrate this function to use Environment.
        let njFont = font?.with(weight: weight)
        return NJText(string: string, font: njFont?.font, style: style)
    }
}

#Preview {
    NJText("Hello, World!")
        .font(Font.title, weight: .bold)
        .foregroundStyle(Color.red)
}
