//
//  ConditionalModifier.swift
//  ObjectCaptureCamera
//
//  Created by 蘇健豪 on 2021/12/11.
//

import SwiftUI

public extension View {
    /// Applies the given transform if the given condition evaluates is `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func `if`<Content: View, Content2: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content, elseTransform: (Self) -> Content2) -> some View {
        if condition() {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
    
    @ViewBuilder func ifNot<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            self
        } else {
            transform(self)
        }
    }
}
