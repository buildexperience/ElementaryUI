//
//  v.swift
//
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

struct StylingEnvironmentKey: EnvironmentKey {
    static let defaultValue = AnyShapeStyle(.primary)
}

extension EnvironmentValues {
    var foregroundStyle: AnyShapeStyle {
        get {
            self[StylingEnvironmentKey.self]
        }
        set {
            self[StylingEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    func foreground<S: ShapeStyle>(style: S) -> some View {
        environment(\.foregroundStyle, AnyShapeStyle(style))
    }
}

struct TestView: View {
    var body: some View {
        NJText("Hello")
            .foreground(style: .red)
            .font(.caption2)
    }
}

struct ComponentView: View {
    @Environment(\.foregroundStyle) var foregroundStyle
    @Environment(\.font) var font
    var body: some View {
        NJText("Hello")
            .foregroundStyle(foregroundStyle)
            .font(font ?? .title)
    }
}

#Preview(body: {
    TestView()
        .foreground(style: .blue)
})
