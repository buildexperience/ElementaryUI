//
//  EMText.swift
//  
//
//  Created by Joe Maghzal on 27/02/2024.
//

import SwiftUI

extension Text {
    /// Creates a text view that displays an ``TextDisplayable``.
    ///
    /// - Parameter text: The content of the text to be displayed.
    @inlinable
    public init<T: TextDisplayable>(_ text: T) {
        switch text.content {
            case .localized(let localizedStringKey, let bundle):
                self.init(localizedStringKey, bundle: bundle)
            case .unlocalized(let string):
                self.init(string)
        }
    }
}
