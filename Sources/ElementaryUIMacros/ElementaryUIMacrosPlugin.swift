//
//  ElementaryUIMacrosPlugin.swift
//  
//
//  Created by Joe Maghzal on 04/05/2024.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

/// Compiler plugin for providing ElementaryUI macros.
@main
struct ElementaryUIMacrosPlugin: CompilerPlugin {
    /// The macros provided by this plugin.
    let providingMacros: [Macro.Type] = [
        HexColorMacro.self,
        EnvironmentKeyMacro.self,
        FocusedValueMacro.self
    ]
}
