//
//  ViewStyle.swift
//
//
//  Created by Joe Maghzal on 29/06/2024.
//

import SwiftUI

/// Requirements  for defining a style for a view, providing a way to customize
/// the appearance & behavior of a view's content.
///
/// - Warning: Do not conform to this protocol directly. You should use
/// the ``Stylable(environmentKey:style:configurations:defaultStyle:)``
/// macro instead.
public protocol ViewStyle<Configuration>: DynamicProperty {
    /// The configuration data needed to create the styled view.
    associatedtype Configuration
    
    /// The body of the styled view.
    associatedtype Body: View
    
    /// The content to be styled.
    typealias Content = AnyView
    
    /// Creates the body of the styled view.
    ///
    /// - Parameters:
    ///   - content: The content to be styled, wrapped in an ``AnyView``.
    ///   - configuration: The configuration data used to customize the styled view.
    ///
    /// - Returns: The styled view.
    @ViewBuilder @MainActor func makeBody(
        content: Self.Content,
        configuration: Self.Configuration
    ) -> Self.Body
}

extension ViewStyle {
    /// Creates the body of the styled view.
    ///
    /// Use this function to style the content of the view after applying other styles to it:.
    ///
    /// ```swift
    /// struct RedContentStyle: ContentViewStyle {
    ///     func makeBody(content: Content, configuration: ContentConfiguration) -> some View {
    ///         RoundedContentStyle().body(content, configuration: configuration) { styledContent in
    ///             styledContent // The content after applying RoundedContentStyle.
    ///                 .foregroundStyle(.red)
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - content: The content to style.
    ///   - configuration: The configuration data used to customize the styled view.
    ///   - styledContent: The styled content.
    ///
    /// - Returns: The styled view.
    @MainActor public func body<StyledContent: View>(
        _ content: Content,
        configuration: Self.Configuration,
        @ViewBuilder _ styledContent: (_ styledContent: Content) -> StyledContent
    ) -> Self.Body {
        makeBody(content: AnyView(styledContent(content)), configuration: configuration)
    }
}
