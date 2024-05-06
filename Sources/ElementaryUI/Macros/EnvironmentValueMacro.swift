//
//  EnvironmentValueMacro.swift
//
//
//  Created by Joe Maghzal on 05/05/2024.
//

import Foundation

/// Macro used to generate the an ``EnvironmentKey``.
///
/// This macro creates an ``EnvironmentKey`` from the property it's applied to & generates the corresponding getter & setter for the property defined in the ``EnvironmentValues`` extension:
///
/// ```swift
/// extension EnvironmentValues {
///     @EnvironmentValue var navigationTitle = "Title"
/// }
///
/// // Expanded
/// extension EnvironmentValues {
///     var navigationTitle = "Title" {
///         get {
///             return self[EnvironmentKey_navigationTitle.self]
///         }
///         set(newValue) {
///             self[EnvironmentKey_navigationTitle.self] = newValue
///         }
///     }
///
///     fileprivate struct EnvironmentKey_navigationTitle: EnvironmentKey {
///         static let defaultValue = true
///     }
/// }
/// ```
/// - Warning: The property must be contained in an ``EnvironmentValues`` extension.
@attached(peer, names: prefixed(EnvironmentKey_))
@attached(accessor, names: named(get), named(set))
public macro EnvironmentValue() = #externalMacro(module: "ElementaryUIMacros", type: "EnvironmentKeyMacro")
