//
//  BorderViewModifiers.swift
//  
//
//  Created by Joe Maghzal on 29/02/2024.
//

import SwiftUI

extension View {
    /// Adds a border with the specified content, line width, and shape to the view.
    ///
    /// ```swift
    /// Color.blue
    ///     .border(Color.red, lineWidth: 10, antialiased: false, shape: .capsule)
    /// ```
    ///
    /// - Parameters:
    ///   - content: The content of the border, a ``ShapeStyle``, defaults to `.foreground`.
    ///   - lineWidth: The width of the border line, defaults to 1.
    ///   - antialiased: A Boolean value indicating whether to use antialiased rendering, defaults to true.
    ///   - shape: The shape of the border, an ``InsettableShape``.
    ///
    /// - Returns: A view with the specified border.
    public func border<T: ShapeStyle, S: InsettableShape>(
        _ content: T = .foreground,
        lineWidth: CGFloat = 1,
        antialiased: Bool = true,
        shape: S
    ) -> some View {
        overlay {
            shape
                .strokeBorder(content, lineWidth: lineWidth, antialiased: antialiased)
        }.clipShape(shape)
    }
    
    /// Adds a border with the specified content, stroke style, and shape to the view.
    ///
    /// ```swift
    /// Color.blue
    ///     .border(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: [5, 1]), antialiased: false, shape: .capsule)
    /// ```
    ///
    /// - Parameters:
    ///   - content: The content of the border,  a ``ShapeStyle``, defaults to `.foreground`.
    ///   - style: The stroke style of the border.
    ///   - antialiased: A Boolean value indicating whether to use antialiased rendering, defaults to true.
    ///   - shape: The shape of the border, an ``InsettableShape``.
    ///
    /// - Returns: A view with the specified border.
    public func border<T: ShapeStyle, S: InsettableShape>(
        _ content: T = .foreground,
        style: StrokeStyle,
        antialiased: Bool = true,
        shape: S
    ) -> some View {
        overlay {
            shape
                .strokeBorder(content, style: style, antialiased: antialiased)
        }.clipShape(shape)
    }
}
