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
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
                typealias Configuration = \(configurations)
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
        let environmentKey = "defaultMyViewStyle2"
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
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
    func testMacroExpansionWithAccessLevelArgument() {
        assertMacroExpansion(
            """
            @Stylable(accessLevel: .private)
            public struct MyView: View {
            }
            """,
            expandedSource: """
            public struct MyView: View {
            }
            
            private protocol MyViewStyle: ViewStyle where Configuration == MyViewConfiguration {
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
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
        let error = StylableMacroError.missingViewConformance(name: "MyView")
        // Missing View conformance.
        let diagnostic = DiagnosticSpec(
            message: error.message,
            line: 1,
            column: 1,
            severity: error.severity
        )
        // Expect 2 diagnostics since both the PeerMacro & the ExtensionMacro fail & throws the error.
        let expectedDiagnostics = [diagnostic, diagnostic]
        assertMacroExpansion(
            """
            @Stylable
            enum MyView { }
            """,
            expandedSource: """
            enum MyView { }
            
            protocol MyViewStyle: ViewStyle where Configuration == MyViewConfiguration {
                typealias Configuration = MyViewConfiguration
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
    func testMacroFailsWithInvalidAccessLevel() {
        let modifier = "publicss"
        let error = StylableMacroError.invalidAccessModifier(modifier)
        // Missing View conformance.
        let diagnostic = DiagnosticSpec(
            message: error.message,
            line: 1,
            column: 1,
            severity: error.severity
        )
        // Expect 2 diagnostics since both the PeerMacro & the ExtensionMacro fail & throws the error.
        let expectedDiagnostics = [diagnostic]
        assertMacroExpansion(
            """
            @Stylable(accessLevel: .\(modifier))
            struct MyView: View { }
            """,
            expandedSource: """
            struct MyView: View { }
            
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
                        let newContent = style.makeBody(
                            content: content,
                            configuration: configuration
                        )
            
                        VStack {
                            AnyView(currentStyle.makeBody(
                                content: AnyView(newContent),
                                configuration: configuration)
                            )
                        }
                    }
                }
            }
            """,
            diagnostics: expectedDiagnostics,
            macros: testMacros
        )
    }
}
#endif
