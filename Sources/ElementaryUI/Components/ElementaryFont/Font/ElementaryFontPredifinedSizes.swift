//
//  ElementaryFontPredifinedSizes.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

public extension ElementaryFont {
    /// Font size: 34 pts.
    static func largeTitle(_ weight: Weight? = nil) -> Font {
        return custom(34, weight: weight, relativeTo: .largeTitle)
    }
    
    /// Font size: 28 pts.
    static func title(_ weight: Weight? = nil) -> Font {
        return custom(28, weight: weight, relativeTo: .title)
    }
    
    /// Font size: 22 pts.
    static func title2(_ weight: Weight? = nil) -> Font {
        return custom(22, weight: weight, relativeTo: .title2)
    }
    
    /// Font size: 20 pts.
    static func title3(_ weight: Weight? = nil) -> Font {
        return custom(20, weight: weight, relativeTo: .title3)
    }
    
    /// Font size: 17 pts, with `semibold` weight.
    static func headline(_ weight: Weight? = nil) -> Font {
        return custom(17, weight: weight, relativeTo: .headline)
    }
    
    /// Font size: 15 pts.
    static func subheadline(_ weight: Weight? = nil) -> Font {
        return custom(15, weight: weight, relativeTo: .subheadline)
    }
    
    /// Font size: 17 pts.
    static func body(_ weight: Weight? = nil) -> Font {
        return custom(17, weight: weight, relativeTo: .body)
    }
    
    /// Font size: 16 pts.
    static func callout(_ weight: Weight? = nil) -> Font {
        return custom(16, weight: weight, relativeTo: .callout)
    }
    
    /// Font size: 13 pts.
    static func footnote(_ weight: Weight? = nil) -> Font {
        return custom(13, weight: weight, relativeTo: .footnote)
    }
    
    /// Font size: 12 pts.
    static func caption(_ weight: Weight? = nil) -> Font {
        return custom(12, weight: weight, relativeTo: .caption)
    }
    
    /// Font size: 11 pts.
    static func caption2(_ weight: Weight? = nil) -> Font {
        return custom(11, weight: weight, relativeTo: .caption2)
    }
}
