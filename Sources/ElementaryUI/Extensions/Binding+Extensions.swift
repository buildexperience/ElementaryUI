//
//  Binding+Extensions.swift
//  
//
//  Created by Joe Maghzal on 16/07/2024.
//

import SwiftUI

extension Binding {
    /// Maps the current binding to a new binding with a different value type 
    /// using custom getter & setter transformations.
    ///
    /// - Parameters:
    ///   - getterTransform: A closure that transforms the current binding value 
    ///   to the new binding value.
    ///   - setterTransform: A closure that transforms the new binding value 
    ///   back to the original binding value.
    ///
    /// - Returns: A new binding that applies the specified transformations.
    @inlinable public func map<Mapped>(
        _ getterTransform: @escaping @Sendable (Value) -> Mapped,
        _ setterTransform: @escaping @Sendable (Mapped) -> Value
    ) -> Binding<Mapped> {
        return Binding<Mapped> {
            return getterTransform(wrappedValue)
        }set: { newValue in
            self.transaction(transaction).wrappedValue = setterTransform(newValue)
        }
    }
    
    /// Maps the current binding to a new binding with a different value type using a writable key path.
    ///
    /// - Parameter keyPath: A writable key path from the current binding value 
    /// to the new binding value.
    ///
    /// - Returns: A new binding that applies the specified key path transformation.
    @inlinable public func map<Mapped>(
        _ keyPath: WritableKeyPath<Value, Mapped>
    ) -> Binding<Mapped> {
        return Binding<Mapped> {
            return wrappedValue[keyPath: keyPath]
        }set: { newValue in
            self.transaction(transaction).wrappedValue[keyPath: keyPath] = newValue
        }
    }
    
    /// Maps the current binding to a new binding with a different value type 
    /// using separate non writable getter & setter key paths.
    ///
    /// - Parameters:
    ///   - getterKeyPath: A non writable key path from the current binding value 
    ///   to the new binding value.
    ///   - setterKeyPath: A non writable key path from the new binding value 
    ///   back to the original binding value.
    ///
    /// - Returns: A new binding that applies the specified key paths transformations.
    @inlinable public func map<Mapped>(
        _ getterKeyPath: KeyPath<Value, Mapped>,
        _ setterKeyPath: KeyPath<Mapped, Value>
    ) -> Binding<Mapped> {
        return Binding<Mapped> {
            return wrappedValue[keyPath: getterKeyPath]
        }set: { newValue, transaction in
            self.transaction(transaction).wrappedValue = newValue[keyPath: setterKeyPath]
        }
    }
}
