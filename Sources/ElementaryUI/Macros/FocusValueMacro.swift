//
//  FocusValueMacro.swift
//
//
//  Created by Joe Maghzal on 06/05/2024.
//

import Foundation

/// Macro used to generate the an ``PrefrenceKey``.
///
/// This macro creates a ``FocusedValueKey`` from the property it's applied to 
/// & generates the corresponding getter & setter for the property defined in
/// the ``FocusedValueKey`` extension:
///
/// ```swift
/// extension FocusedValues {
///     @FocusedValue var signInFocus: String?
/// }
///
/// // Expanded
/// extension FocusedValues {
///     var signInFocus: String? {
///         get {
///             return self[FocusedValueKey_signInFocus.self]
///         }
///         set(newValue) {
///             self[FocusedValueKey_signInFocus.self] = newValue
///         }
///     }
///
///     fileprivate struct FocusedValueKey_signInFocus: FocusedValueKey {
///         typealias Value = String
///     }
/// }
/// ```
/// - Warning: The property must be contained in a ``FocusedValues`` extension.
/// 
/// - Warning: The property type must be optional.
#if canImport(SwiftUICore)
@available(swift, deprecated: 6.0, renamed: "Entry", message: "Please use the official `Entry` macro.")
#endif
@attached(peer, names: prefixed(FocusedValueKey_))
@attached(accessor, names: named(get), named(set))
public macro FocusValue() = #externalMacro(
    module: "ElementaryUIMacros",
    type: "FocusedValueMacro"
)
