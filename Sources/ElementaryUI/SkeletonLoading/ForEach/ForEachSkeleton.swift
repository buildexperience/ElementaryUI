//
//  ForEachSkeleton.swift
//
//
//  Created by Joe Maghzal on 09/03/2024.
//

import SwiftUI

/// View designed to display skeleton loading for a list of items using ``ForEach``.
///
/// - Warning: Not to be used directly, use ``func skeletonLoadable()``.
///
struct ForEachSkeletonView<Content: DynamicViewContent, RowContent: View>: DynamicViewContent where Content.Data.Element: Identifiable {
    /// The value indicating whether skeleton loading is active.
    @Environment(\.skeletonLoading) private var skeletonLoading
    
    /// The skeleton data to be displayed.
    private let skeletonData: [Content.Data.Element]
    
    /// The closure used to produce the content for each item.
    private let rowContent: (Content.Data.Element) -> RowContent
    
    /// The content view containing the real data.
    private let content: Content
    
    /// The data to be displayed.
    var data: [Content.Data.Element] {
        return Array(content.data)
    }
    
    /// The body of the ``View``.
    var body: some View {
        ForEach(data) { item in
            rowContent(item)
        }.disabled(skeletonLoading)
    }
}

//MARK: - Initializer
extension ForEachSkeletonView {
    /// Creates a new ``ForEachSkeletonView`` that handles displaying skeleton data or real data based on the skeleton state.
    ///
    /// - Parameters:
    ///   - content: The content view containing the real data.
    ///   - skeletonData: The skeleton data to be displayed.
    ///   - rowContent: The closure used to produce the content for each item.
    ///
    init(content: Content, skeletonData: [Content.Data.Element], rowContent: @escaping (Content.Data.Element) -> RowContent) {
        self.content = content
        self.skeletonData = skeletonData
        self.rowContent = rowContent
    }
}

//MARK: - Modifiers
public extension ForEach where Data.Element: SkeletonRepresentable, Content: View {
    /// Makes a ``ForEach`` automatically load skeleton data when skeleton loading is active.
    ///
    /// Use it only on a ``ForEach`` to automatically load skeleton data when skeleton loading is active. You will still be able to use any modifier specific to ``ForEach`` or ``DynamicViewContent`` after using this modifier.
    ///
    /// ```swift
    /// struct TestView: View {
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
    /// - Warning: This modifier should be used before using any other modifier specific to ``ForEach`` or ``DynamicViewContent``.
    ///
    func skeletonLoadable() -> some DynamicViewContent {
        ForEachSkeletonView(content: self, skeletonData: Data.Element.skeleton, rowContent: content)
    }
}
