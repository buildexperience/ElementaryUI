//
//  EMTextFieldStyleConfiguration.swift
//
//
//  Created by Joe Maghzal on 06/04/2024.
//

import SwiftUI

/// Configurations for ``EMTextField`` used in an ``EMTextFieldStyle``.
public struct EMTextFieldStyleConfiguration {
    
    /// The binding to the text value of the text field.
    public let text: Binding<String>
    
    /// The validation state of the text field.
    public let validation: Bool?
}
