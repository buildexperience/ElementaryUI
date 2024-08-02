//
//  OnChangeModifier.swift
//
//
//  Created by Joe Maghzal on 17/07/2024.
//

import SwiftUI

@available(iOS, deprecated: 17.0, message: "Use `onChange` with a two or zero parameter action closure instead.")
@available(macOS, deprecated: 14.0, message: "Use `onChange` with a two or zero parameter action closure instead.")
@available(watchOS, deprecated: 10.0, message: "Use `onChange` with a two or zero parameter action closure instead.")
@available(tvOS, deprecated: 15.0, message: "Use `onChange` with a two or zero parameter action closure instead.")
@available(visionOS, deprecated: 1.0, message: "Use `onChange` with a two or zero parameter action closure instead.")
extension View {
    /// Adds a modifier for this view that fires an action when a specific
    /// value changes.
    ///
    /// You can use `onChange` to trigger a side effect as the result of a
    /// value changing, such as an `Environment` key or a `Binding`.
    ///
    /// The system may call the action closure on the main actor, so avoid
    /// long-running tasks in the closure. If you need to perform such tasks,
    /// detach an asynchronous background task.
    ///
    /// When the value changes, the new version of the closure will be called,
    /// so any captured values will have their values from the time that the
    /// observed value has its new value. The old & new observed values are
    /// passed into the closure. In the following code example, `PlayerView`
    /// passes both the old & new values to the model.
    ///
    ///     struct PlayerView: View {
    ///         var episode: Episode
    ///         @State private var playState: PlayState = .paused
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 Text(episode.title)
    ///                 Text(episode.showTitle)
    ///                 PlayButton(playState: $playState)
    ///             }
    ///             .onChange(of: playState) { oldState, newState in
    ///                 model.playStateDidChange(from: oldState, to: newState)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - value: The value to check against when determining whether to run the closure.
    ///   - onAppear: Whether the action should be run when this view initially appears.
    ///   - action: A closure to run when the value changes.
    ///   - oldValue: The old value that failed the comparison check (or the initial value when requested).
    ///   - newValue: The new value that failed the comparison check.
    ///
    /// - Returns: A view that fires an action when the specified value changes.
    @_disfavoredOverload
    @ViewBuilder public func onChange<V: Equatable>(
        of value: V,
        initial: Bool = false,
        _ action: @escaping (_ oldValue: V, _ newValue: V) -> Void
    ) -> some View {
        if #available(iOS 17.0, macOS 14.0, watchOS 10.0, *) {
            self
                .onChange(of: value, initial: initial, action)
        }else {
            if initial {
                self
                    .onAppear {
                        action(value, value)
                    }.onChange(of: value) { [value] newValue in
                        let oldValue = value
                        action(oldValue, newValue)
                    }
            }else {
                self
                    .onChange(of: value) { [value] newValue in
                        let oldValue = value
                        action(oldValue, newValue)
                    }
            }
        }
    }
}
