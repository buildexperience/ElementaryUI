//
//  Line.swift
//  
//
//  Created by Joe Maghzal on 20/07/2024.
//

import SwiftUI

/// A shape representing a horizontal line.
@MainActor public struct Line: Shape, Animatable, Sendable {
    /// Creates a horizontal line.
    @inlinable public init() { }
    
    /// Describes this shape as a path within a rectangular frame of reference.
    ///
    /// - Parameter rect: The frame of reference for describing this shape.
    ///
    /// - Returns: A path that describes this shape.
    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rect.origin)
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}
