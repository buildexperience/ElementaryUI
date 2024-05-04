//
//  ElementaryUIMacrosPlugin.swift
//  
//
//  Created by Joe Maghzal on 04/05/2024.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ElementaryUIMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        HexColorMacro.self
    ]
}
