//
//  RoundableRectangle.swift
//
//
//  Created by Joe Maghzal on 20/07/2024.
//

import SwiftUI

/// A rectangular shape with rounded corners with different values, aligned
/// inside the frame of the view containing it.
@available(iOS, deprecated: 16.0, message: "Use `UnevenRoundedRectangle` instead.")
@available(macOS, deprecated: 13.0, message: "Use `UnevenRoundedRectangle` instead.")
@available(watchOS, deprecated: 9.0, message: "Use `UnevenRoundedRectangle` instead.")
public struct RoundableRectangle: Shape, Animatable, Sendable {
    /// The inset amount applied to the frame of the shape.
    @usableFromInline internal var inset = CGFloat.zero
    
    /// The radii of each corner of the rounded rectangle.
    public var cornerRadii: CornerRadii
    
    /// Describes this shape as a path within a rectangular frame of reference.
    ///
    /// - Parameter rect: The frame of reference for describing this shape.
    ///
    /// - Returns: A path that describes this shape.
    public func path(in rect: CGRect) -> Path {
        Path { path in
            // Top Leading
            let insettedRect = insettedRect(rect)
            
            let p1 = CGPoint(x: insettedRect.minX, y: insettedRect.minY + cornerRadii.topLeading)
            let p2 = CGPoint(x: insettedRect.minX + cornerRadii.topLeading, y: insettedRect.minY)
            
            path.move(to: p1)
            path.addArc(
                tangent1End: CGPoint(x: insettedRect.minX, y: insettedRect.minY),
                tangent2End: p2,
                radius: cornerRadii.topLeading
            )
            
            // Top Trailing
            let p3 = CGPoint(x: insettedRect.maxX - cornerRadii.topTrailing, y: insettedRect.minY)
            let p4 = CGPoint(x: insettedRect.maxX, y: insettedRect.minY + cornerRadii.topTrailing)
            
            path.addLine(to: p3)
            path.addArc(
                tangent1End: CGPoint(x: insettedRect.maxX, y: insettedRect.minY),
                tangent2End: p4,
                radius: cornerRadii.topTrailing
            )
            
            // Bottom Trailing
            let p5 = CGPoint(x: insettedRect.maxX, y: insettedRect.maxY - cornerRadii.bottomTrailing)
            let p6 = CGPoint(x: insettedRect.maxX - cornerRadii.bottomTrailing, y: insettedRect.maxY)
            
            path.addLine(to: p5)
            path.addArc(
                tangent1End: CGPoint(x: insettedRect.maxX, y: insettedRect.maxY),
                tangent2End: p6,
                radius: cornerRadii.bottomTrailing
            )
            
            // Bottom Leading
            let p7 = CGPoint(x: insettedRect.minX + cornerRadii.bottomLeading, y: insettedRect.maxY)
            let p8 = CGPoint(x: insettedRect.minX, y: insettedRect.maxY - cornerRadii.bottomLeading)
            
            path.addLine(to: p7)
            path.addArc(
                tangent1End: CGPoint(x: insettedRect.minX, y: insettedRect.maxY),
                tangent2End: p8,
                radius: cornerRadii.bottomLeading
            )
            
            path.closeSubpath()
        }
    }
    
    /// Calculates the insetted frame by applying the current inset.
    ///
    /// - Parameter rect: The original frame.
    ///
    /// - Returns: A new frame inset by the current inset amount.
    @inline(__always) private func insettedRect(_ rect: CGRect) -> CGRect {
        let doubleInset = inset * 2
        return CGRect(
            x: rect.minX + inset,
            y: rect.minY + inset,
            width: rect.width - doubleInset,
            height: rect.height - doubleInset
        )
    }
}

//MARK: - InsettableShape
extension RoundableRectangle: InsettableShape {
    /// Returns `self` inset by `amount`.
    @inlinable public func inset(by amount: CGFloat) -> some InsettableShape {
        var insettableShape = self
        insettableShape.inset += amount
        return insettableShape
    }
}

//MARK: - Initializers
extension RoundableRectangle {
    /// Creates a new rounded rectangle shape with uneven corners.
    ///
    /// - Parameter cornerRadii: the radii of each corner.
    public init(cornerRadii: CornerRadii) {
        self.cornerRadii = cornerRadii
    }
    
    /// Creates a new rounded rectangle shape with uneven corners.
    /// 
    /// - Parameters:
    ///   - topLeadingRadius: The radius of the top leading corner.
    ///   - bottomLeadingRadius: The radius of the bottom leading corner.
    ///   - bottomTrailingRadius: The radius of the bottom trailing corner.
    ///   - topTrailingRadius: The radius of the top trailing corner.
    @inlinable
    public init(
        topLeadingRadius: CGFloat = 0,
        bottomLeadingRadius: CGFloat = 0,
        bottomTrailingRadius: CGFloat = 0,
        topTrailingRadius: CGFloat = 0
    ) {
        self.init(
            cornerRadii: CornerRadii(
                topLeading: topLeadingRadius,
                bottomLeading: bottomLeadingRadius,
                bottomTrailing: bottomTrailingRadius,
                topTrailing: topTrailingRadius
            )
        )
    }
}

/// Describes the corner radius values of a rounded rectangle with uneven corners.
public struct CornerRadii: Equatable, Hashable, Animatable, Sendable {
    /// The radius of the top-leading corner.
    public var topLeading: CGFloat
    
    /// The radius of the bottom-leading corner.
    public var bottomLeading: CGFloat
    
    /// The radius of the bottom-trailing corner.
    public var bottomTrailing: CGFloat
    
    /// The radius of the top-trailing corner.
    public var topTrailing: CGFloat
    
    /// Creates a new set of corner radii for a rounded rectangle with uneven corners.
    ///
    /// - Parameters:
    ///   - topLeading: the radius of the top-leading corner.
    ///   - bottomLeading: the radius of the bottom-leading corner.
    ///   - bottomTrailing: the radius of the bottom-trailing corner.
    ///   - topTrailing: the radius of the top-trailing corner.
    public init(
        topLeading: CGFloat = 0,
        bottomLeading: CGFloat = 0,
        bottomTrailing: CGFloat = 0,
        topTrailing: CGFloat = 0
    ) {
        self.topLeading = topLeading
        self.bottomLeading = bottomLeading
        self.bottomTrailing = bottomTrailing
        self.topTrailing = topTrailing
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, *)
#Preview {
    RoundableRectangle(topLeadingRadius: 12)
        .inset(by: 10)
        .fill(.red)
        .overlay {
            UnevenRoundedRectangle(topLeadingRadius: 12)
                .inset(by: 20)
                .fill(.blue)
        }.padding(30)
}
