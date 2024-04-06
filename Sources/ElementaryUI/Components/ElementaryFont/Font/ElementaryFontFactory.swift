//
//  ElementaryFontFactory.swift
//  
//
//  Created by Joe Maghzal on 06/04/2024.
//

import Foundation

public protocol ElementaryFontFactory {
    associatedtype Weight: RawRepresentable, CaseIterable where Weight.RawValue == String
    var fontExtension: String {get}
    func register(bundle: Bundle)
    func font(weight: Weight?) -> String
}

public extension ElementaryFontFactory {
    func register(bundle: Bundle) {
        Weight.allCases.forEach { weight in
            let font = font(weight: weight)
            FontsManager.registerFont(font, fontExtension: fontExtension, bundle: bundle)
        }
    }
}
