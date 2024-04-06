//
//  ElementaryFont.swift
//  
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

public protocol ElementaryFont {
    associatedtype Weight: RawRepresentable, CaseIterable where Weight.RawValue == String
    associatedtype Factory: ElementaryFontFactory where Factory.Weight == Weight
    static func custom(_ size: CGFloat, weight: Weight?, relativeTo textStyle: Font.TextStyle?) -> Font
}

extension ElementaryFont {
    static func custom(_ size: CGFloat, weight: Weight? = nil, relativeTo textStyle: Font.TextStyle? = nil) -> Font {
        return custom(size, weight: weight, relativeTo: textStyle)
    }
}
