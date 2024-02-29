//
//  BorderViewModifiers.swift
//  
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

public extension View {
    /// Adds a border with the specified content, line width, and shape to the view.
    ///
    /// - Parameters:
    ///  - content: The content of the border, a `ShapeStyle`.
    ///  - lineWidth: The width of the border line.
    ///  - antialiased: A Boolean value indicating whether to use antialiased rendering.
    ///  - shape: The shape of the border.
    ///
    /// - Returns: A view with the specified border.
    ///
    func border<T: ShapeStyle, S: InsettableShape>(_ content: T = .foreground, lineWidth: CGFloat = 1, antialiased: Bool = true, shape: S) -> some View {
        overlay {
            shape
                .strokeBorder(content, lineWidth: lineWidth, antialiased: antialiased)
        }.clipShape(shape)
    }
    
    /// Adds a border with the specified content, stroke style, and shape to the view.
    ///
    /// - Parameters:
    ///  - content: The content of the border,  a `ShapeStyle`.
    ///  - style: The stroke style of the border.
    ///  - antialiased: A Boolean value indicating whether to use antialiased rendering.
    ///  - shape: The shape of the border.
    ///
    /// - Returns: A view with the specified border.
    ///
    func border<T: ShapeStyle, S: InsettableShape>(_ content: T = .foreground, style: StrokeStyle, antialiased: Bool = true, shape: S) -> some View {
        overlay {
            shape
                .strokeBorder(content, style: style, antialiased: antialiased)
        }.clipShape(shape)
    }
}

#Preview {
    Color.red
        .border(lineWidth: 10, shape: .capsule)
}
