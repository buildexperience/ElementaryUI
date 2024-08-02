//
//  StylableMacroTests.swift
//
//
//  Created by Joe Maghzal on 29/06/2024.
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ElementaryUIMacros)
import ElementaryUIMacros

final class StylableMacroTests: XCTestCase {
// MARK: - Properties
    private let testMacros: [String: Macro.Type] = [
        "Stylable": StylableMacro.self,
    ]
    
// MARK: - Tests
    func testMacroExpansion() {
        assertMacroExpansion(
            """
            @Stylable
            struct MyView: View {
            }
            """,
            expandedSource: """
            struct MyView: View {
            }
            
            protocol MyViewStyle: ViewStyle where Configuration == MyViewConfiguration {
            }
            
            extension MyView {
                internal struct StyleViewModifier<Style: MyViewStyle>: ViewModifier {
                    @Environment(\\.myViewStyle) private var currentStyle
                    private let style: Style
                    private var newStyle: any MyViewStyle {
                        return AggregatedStyle(currentStyle: currentStyle, style: style)
                    }
            
                    internal init(style: Style) {
                        self.style = style
                    }
            
                    internal func body(content: Content) -> some View {
                        content
                            .environment(\\.myViewStyle, newStyle)
                    }
                }
            }
            
            extension MyView {
                fileprivate struct AggregatedStyle<Style: MyViewStyle>: MyViewStyle {
                    private let currentStyle: any MyViewStyle
                    private let style: Style
            
                    fileprivate init(currentStyle: any MyViewStyle, style: Style) {
                        self.currentStyle = currentStyle
                        self.style = style
                    }
            
                    fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                        let newContent = currentStyle.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(style.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroExpansionWithAccessLevel() {
        assertMacroExpansion(
            """
            @Stylable
            public struct MyView: View {
            }
            """,
            expandedSource: """
            public struct MyView: View {
            }
            
            public protocol MyViewStyle: ViewStyle where Configuration == MyViewConfiguration {
            }
            
            extension MyView {
                internal struct StyleViewModifier<Style: MyViewStyle>: ViewModifier {
                    @Environment(\\.myViewStyle) private var currentStyle
                    private let style: Style
                    private var newStyle: any MyViewStyle {
                        return AggregatedStyle(currentStyle: currentStyle, style: style)
                    }
            
                    internal init(style: Style) {
                        self.style = style
                    }
            
                    internal func body(content: Content) -> some View {
                        content
                            .environment(\\.myViewStyle, newStyle)
                    }
                }
            }
            
            extension MyView {
                fileprivate struct AggregatedStyle<Style: MyViewStyle>: MyViewStyle {
                    private let currentStyle: any MyViewStyle
                    private let style: Style
            
                    fileprivate init(currentStyle: any MyViewStyle, style: Style) {
                        self.currentStyle = currentStyle
                        self.style = style
                    }
            
                    fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                        let newContent = currentStyle.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(style.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
// MARK: - Arguments Tests
    func testMacroExpansionWithConfigurationsArgument() {
        let configurations = "MyView2Configuration"
        assertMacroExpansion(
            """
            @Stylable(configurations: \(configurations).self)
            public struct MyView: View {
            }
            """,
            expandedSource: """
            public struct MyView: View {
            }
            
            public protocol MyViewStyle: ViewStyle where Configuration == \(configurations) {
            }
            
            extension MyView {
                internal struct StyleViewModifier<Style: MyViewStyle>: ViewModifier {
                    @Environment(\\.myViewStyle) private var currentStyle
                    private let style: Style
                    private var newStyle: any MyViewStyle {
                        return AggregatedStyle(currentStyle: currentStyle, style: style)
                    }
            
                    internal init(style: Style) {
                        self.style = style
                    }
            
                    internal func body(content: Content) -> some View {
                        content
                            .environment(\\.myViewStyle, newStyle)
                    }
                }
            }
            
            extension MyView {
                fileprivate struct AggregatedStyle<Style: MyViewStyle>: MyViewStyle {
                    private let currentStyle: any MyViewStyle
                    private let style: Style
            
                    fileprivate init(currentStyle: any MyViewStyle, style: Style) {
                        self.currentStyle = currentStyle
                        self.style = style
                    }
            
                    fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                        let newContent = currentStyle.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(style.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroExpansionWithProtocolArgument() {
        let style = "MyView2Style"
        let formattedStyle = "myView2Style"
        
        assertMacroExpansion(
            """
            @Stylable(styleProtocol: "\(style)")
            public struct MyView: View {
            }
            """,
            expandedSource: """
            public struct MyView: View {
            }
            
            public protocol \(style): ViewStyle where Configuration == MyViewConfiguration {
            }
            
            extension MyView {
                internal struct StyleViewModifier<Style: \(style)>: ViewModifier {
                    @Environment(\\.\(formattedStyle)) private var currentStyle
                    private let style: Style
                    private var newStyle: any \(style) {
                        return AggregatedStyle(currentStyle: currentStyle, style: style)
                    }
            
                    internal init(style: Style) {
                        self.style = style
                    }
            
                    internal func body(content: Content) -> some View {
                        content
                            .environment(\\.\(formattedStyle), newStyle)
                    }
                }
            }
            
            extension MyView {
                fileprivate struct AggregatedStyle<Style: \(style)>: \(style) {
                    private let currentStyle: any \(style)
                    private let style: Style
            
                    fileprivate init(currentStyle: any \(style), style: Style) {
                        self.currentStyle = currentStyle
                        self.style = style
                    }
            
                    fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                        let newContent = currentStyle.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(style.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
    
    func testMacroExpansionWithEnvironmentKeyArgument() {
        let environmentKey = "DefaultMyViewStyle2"
        assertMacroExpansion(
            """
            @Stylable(environmentKey: "\(environmentKey)"
            public struct MyView: View {
            }
            """,
            expandedSource: """
            public struct MyView: View {
            }
            
            public protocol MyViewStyle: ViewStyle where Configuration == MyViewConfiguration {
            }
            
            extension MyView {
                internal struct StyleViewModifier<Style: MyViewStyle>: ViewModifier {
                    @Environment(\\.\(environmentKey)) private var currentStyle
                    private let style: Style
                    private var newStyle: any MyViewStyle {
                        return AggregatedStyle(currentStyle: currentStyle, style: style)
                    }
            
                    internal init(style: Style) {
                        self.style = style
                    }
            
                    internal func body(content: Content) -> some View {
                        content
                            .environment(\\.\(environmentKey), newStyle)
                    }
                }
            }
            
            extension MyView {
                fileprivate struct AggregatedStyle<Style: MyViewStyle>: MyViewStyle {
                    private let currentStyle: any MyViewStyle
                    private let style: Style
            
                    fileprivate init(currentStyle: any MyViewStyle, style: Style) {
                        self.currentStyle = currentStyle
                        self.style = style
                    }
            
                    fileprivate func makeBody(content: Content, configuration: Style.Configuration) -> some View {
                        let newContent = currentStyle.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(style.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            macros: testMacros
        )
    }

// MARK: - Diagnostic Tests
    func testMacroFailsWithMissingViewConformance() {
        // Missing View conformance.
        let diagnostic = DiagnosticSpec(
            message: StylableMacroError.missingViewConformance(name: "MyView").message,
            line: 1,
            column: 1
        )
        // Expect 2 diagnostics since both the PeerMacro & the ExtensionMacro fail & throws the error.
        let expectedDiagnostics = [diagnostic, diagnostic]
        assertMacroExpansion(
            """
            @Stylable
            struct MyView {
            }
            """,
            expandedSource: """
            struct MyView {
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
}
#endif
