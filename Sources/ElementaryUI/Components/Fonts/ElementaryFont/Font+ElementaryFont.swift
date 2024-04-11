//
//  Font+ElementaryFont.swift
//
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI

extension Font: ElementaryFont {
    public static func custom(size: CGFloat, weight: Weight?, relativeTo textStyle: TextStyle?) -> Font {
        return Font.system(size: size, weight: weight)
    }
    public static func custom(_ style: TextStyle, weight: Weight?) -> Font {
        return Font.system(style, weight: weight)
    }
}
