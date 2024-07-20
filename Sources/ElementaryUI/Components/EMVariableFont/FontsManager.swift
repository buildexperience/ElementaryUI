//
//  FontsManager.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// Manager responsible for registering custom fonts within the application.
///
/// ```swift
/// FontsManager.registerFont("Halvetica", fontExtension: "ttf", bundle: .module)
/// ```
public enum FontsManager {
    /// Registers a custom font with the specified name, font extension, & bundle.
    ///
    /// ```swift
    /// FontsManager.registerFont("Halvetica", fontExtension: "ttf", bundle: .module)
    /// ```
    ///
    /// - Parameters:
    ///   - name: The name of the font.
    ///   - fontExtension: The file extension of the font file.
    ///   - bundle: The bundle containing the font file.
    ///
    ///  - Note: This function does nothing if the provided font was already registered.
    public static func registerFont(_ name: String, fontExtension: String, bundle: Bundle) {
        // Find the font file URL in the provided bundle.
        guard let fontURL = bundle.url(forResource: name, withExtension: fontExtension) else {
            assertionFailure("Could not find the url corresponding to the font \(name)")
            return
        }
        // Create a CGFont instance from the font URL.
        guard let font = cgFont(from: fontURL) else {
            assertionFailure("Could not create the font \(name) using the url: \(fontURL)")
            return
        }
        // Register the font
        guard let error = register(font) else {return}
        assertionFailure(String(describing: error))
    }
}

//MARK: - Private Functions
extension FontsManager {
    /// Registers the given ``CGFont`` with the Core Text font manager.
    ///
    /// - Parameter font: The font to register.
    /// - Returns: An ``Unmanaged<CFError>`` object if an error occurred during registration, nil otherwise.
    @inline(__always)
    private static func register(_ font: CGFont) -> Unmanaged<CFError>? {
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        guard let error else {
            return nil
        }
        return error
    }
    
    /// Creates a ``CGFont`` from the font file located at the specified URL.
    ///
    /// - Parameter url: The URL of the font file.
    /// - Returns: A ``CGFont`` object if successful, nil otherwise.
    @inline(__always)
    private static func cgFont(from url: URL) -> CGFont? {
        guard let dataProvider = CGDataProvider(url: url as CFURL) else {
            return nil
        }
        return CGFont(dataProvider)
    }
}
