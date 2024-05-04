//
//  HexColorMacro.swift
//  
//
//  Created by Joe Maghzal on 04/05/2024.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct HexColorMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let argument = node.argumentList.first?.expression,
              let argumentSegment = argument.as(StringLiteralExprSyntax.self)?.segments.first,
              case .stringSegment(let argumentString) = argumentSegment
        else {
            throw HexColorMacroError.missingHex
        }
        let hex = argumentString.content.text
        let decodingResult = HexColorDecoder.decode(hex)
        switch decodingResult {
            case .success((let red, let green, let blue, let opacity)):
                return "Color(red: \(raw: red)/255, green: \(raw: green)/255, blue: \(raw: blue)/255, opacity: \(raw: opacity)/255)"
                
            case .failure(let error):
               throw error
        }
    }
}
