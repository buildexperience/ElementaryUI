//
//  ForEachSkeleton.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// ``View`` designed to display skeleton loading for a list of items using ``ForEach``.
///
/// - Warning: This is an internal modifier not meant to be used directly. 
/// You should use ``skeletonLoadable()`` instead.
fileprivate struct ForEachSkeletonView<
    Content: DynamicViewContent,
    RowContent: View
>: DynamicViewContent where Content.Data.Element: Identifiable {
    /// The value indicating whether skeleton loading is active.
    @Environment(\.skeletonLoading) private var skeletonLoading
    
    /// The content view containing the real data.
    fileprivate let content: Content
    
    /// The skeleton data to be displayed.
    fileprivate let skeletonData: [Content.Data.Element]
    
    /// The closure used to produce the content for each item.
    fileprivate let rowContent: (_ row: Content.Data.Element) -> RowContent
    
    /// The data to be displayed.
    fileprivate var data: [Content.Data.Element] {
        return Array(content.data)
    }
    
    /// The body of the ``View``.
    fileprivate var body: some View {
        ForEach(data) { item in
            rowContent(item)
        }.disabled(skeletonLoading)
    }
}

// MARK: - Modifiers
extension ForEach where Data.Element: SkeletonRepresentable, Content: View {
    /// Makes a ``ForEach`` automatically load skeleton data when skeleton loading is active.
    ///
    /// Use it only on a ``ForEach`` to automatically load skeleton data when skeleton loading is active. 
    /// You will still be able to use any modifier specific to ``ForEach`` or ``DynamicViewContent``
    /// after using this modifier.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var data = [DataItem(), DataItem(), DataItem()]
    ///     var body: some View {
    ///         List {
    ///             ForEach(data) { item in
    ///                 Text(item.id)
    ///             }.skeletonLoadable()
    ///             .onDelete { indexSet in
    ///                 for index in indexSet {
    ///                     data.remove(at: index)
    ///                 }
    ///             }
    ///         }
    ///     }
    /// }
    ///
    /// struct DataItem: Identifiable, SkeletonRepresentable {
    ///     var id = UUID().uuidString
    ///     static var skeleton: [DataItem] = [DataItem()] //Skeleton data
    /// }
    /// ```
    ///
    /// - Returns: A ``DynamicViewContent`` that is skeleton loadable.
    ///
    /// - Warning: This modifier should be used before using any other modifier specific to ``ForEach`` or
    /// ``DynamicViewContent``.
    public func skeletonLoadable() -> some DynamicViewContent {
        return ForEachSkeletonView(
            content: self,
            skeletonData: Data.Element.skeleton,
            rowContent: content
        )
    }
}
