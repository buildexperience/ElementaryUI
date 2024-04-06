//
//  FontsManager.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

public struct FontsManager {
    public static func registerFont(_ name: String, fontExtension: String, bundle: Bundle) {
        guard let fontURL = bundle.url(forResource: name, withExtension: fontExtension) else {
            fatalError("Could not find the url corresponding to the font \(name)")
        }
        guard let font = cgFont(for: fontURL) else {
            fatalError("Could not create the font \(name) using the url: \(fontURL)")
        }
        var error: Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
        guard let error else {return}
        fatalError("Could not register the font \(name), \(error)")
    }
    private static func cgFont(for url: URL) -> CGFont? {
        guard let dataProvider = CGDataProvider(url: url as CFURL) else {
            return nil
        }
        return CGFont(dataProvider)
    }
}
