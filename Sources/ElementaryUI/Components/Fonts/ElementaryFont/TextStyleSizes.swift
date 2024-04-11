//
//  File.swift
//  
//
//  Created by Joe Maghzal on 11/04/2024.
//

import SwiftUI

extension Font.TextStyle {
    /// Returns the font size associated with the text style.
    ///
    /// - Returns: The font size in points.
    /// 
    var size: CGFloat {
        switch self {
            case .largeTitle:
                return 34
            case .title:
                return 28
            case .title2:
                return 22
            case .title3:
                return 20
            case .headline:
                return 15
            case .subheadline:
                return 17
            case .body:
                return 17
            case .callout:
                return 16
            case .footnote:
                return 13
            case .caption:
                return 12
            case .caption2:
                return 11
            @unknown default:
                fatalError()
        }
    }
}
