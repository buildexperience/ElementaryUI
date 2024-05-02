//
//  ElementaryFontFactory.swift
//
//
//  Created by Joe Maghzal on 11/04/2024.
//

import Foundation

/// The requirements for defining a factory that produces font names with different weights, & registering them.
///
/// Defining ``Weight``  is not required when the font has one weight.
/// Implementing ``func register(bundle: Bundle)`` is not required when ``Weight`` conforms to ``CaseIterable`` & ``RawRepresentable``, & its `RawValue` is ``String``.
///
/// **Example conformances:**
///
/// - Conformance using ``CaseIterable`` & ``RawRepresentable<String>`` for ``Weight``:
///
/// ```swift
/// enum FontFactory: ElementaryFontFactory {
///     case regular, italic
///     static var defaultFactory: Nunito.Factory {
///         return .regular
///     }
///     public var fontExtension: String {
///         return "ttf"
///     }
///     public func font(weight: Weight?) -> String {
///         let weight = weight ?? .regular
///         return "\(Halvetica)-\(weight.rawValue)"
///     }
///
///     enum Weight: String, CaseIterable {
///         case regular, bold
///     }
/// }
/// ```
///
/// - Conformance using only ``CaseIterable`` for ``Weight``:
///
/// ```swift
/// enum FontFactory: ElementaryFontFactory {
///     case regular, italic
///     static var defaultFactory: Nunito.Factory {
///         return .regular
///     }
///     public var fontExtension: String {
///         return "ttf"
///     }
///     public func font(weight: Weight?) -> String {
///         let weight = weight ?? .regular
///         return "\(Halvetica)-\(weight.name)"
///     }
///     func register(bundle: Bundle) {
///         Weight.allCases.forEach { weight in
///             let font = font(weight: weight)
///             FontsManager.registerFont(font, fontExtension: fontExtension, bundle: bundle)
///         }
///     }
///
///     struct Weight: CaseIterable {
///         let name: String
///         static let regular = Weight(name: "regular")
///         static let bold = Weight(name: "bold")
///         static let allCases: [Self] = [.regular, .bold]
///     }
/// }
/// ```
///
/// - Conformance without ``Weight``:
///
/// ```swift
/// enum FontFactory: ElementaryFontFactory {
///     case regular, italic
///     static var defaultFactory: Nunito.Factory {
///         return .regular
///     }
///     public var fontExtension: String {
///         return "ttf"
///     }
///     public func font(weight: Never?) -> String {
///         return "Halvetica"
///     }
/// }
/// ```
///
/// - Note: Implementing ``func register(bundle: Bundle)`` is not required when ``Weight`` conforms to ``CaseIterable`` & ``RawRepresentable``, & its `RawValue` is ``String``.
/// 
/// - Note: Implementing ``Weight``  is not required when the font has one weight.
///
public protocol ElementaryFontFactory {
    /// The diffrent weights of the font.
    ///
    /// - Note: The definition for ``Weight`` is optional, & its default implementation is ``Never``. This can be useful for fonts having a single weight.
    ///
    associatedtype Weight
    
    /// The default factory to use..
    static var defaultFactory: Self {get}
    
    /// The file extension of the font files.
    var fontExtension: String {get}
    
    /// Registers the font files from the given bundle.
    ///
    /// - Parameter bundle: The bundle containing the font files.
    /// - Note: The implementation for this function is optional only when ``Weight`` conforms to ``CaseIterable`` & ``RawRepresentable``, & its `RawValue` is ``String``.
    ///
    func register(bundle: Bundle)
    
    /// Returns the font name for the specified weight.
    ///
    /// - Parameter weight: The font weight.
    /// - Returns: The font name.
    ///
    func font(weight: Self.Weight?) -> String
}

//MARK: - Default Implementations
public extension ElementaryFontFactory {
    /// Default implementation of ``Weight``.
    typealias Weight = Never
}

//MARK: - Default Implementations
public extension ElementaryFontFactory where Weight: CaseIterable & RawRepresentable<String> {
    /// Registers all font weights from the specified bundle.
    ///
    /// - Parameter bundle: The bundle containing the font files.
    ///
    func register(bundle: Bundle) {
        Weight.allCases.forEach { weight in
            let font = font(weight: weight)
            FontsManager.registerFont(font, fontExtension: fontExtension, bundle: bundle)
        }
    }
}
