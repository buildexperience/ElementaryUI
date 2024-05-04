//
//  HexColorMacro.swift
//
//
//  Created by Joe Maghzal on 04/05/2024.
//

import SwiftUI

@freestanding(expression)
public macro color(_ hex: StringLiteralType) -> Color = #externalMacro(module: "ElementaryUIMacros", type: "HexColorMacro")

@freestanding(expression)
public macro unsafeColor(_ hex: StringLiteralType) -> Color = #externalMacro(module: "ElementaryUIMacros", type: "UnsafeHexColorMacro")

struct MyView: View {
    var body: some View {
        VStack {
            #color("00b4d8")
            #color("00b4d890")
        }
    }
}

#Preview {
    MyView()
}
