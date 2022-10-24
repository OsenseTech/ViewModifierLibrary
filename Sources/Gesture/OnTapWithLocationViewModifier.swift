//
//  OnTapWithLocationViewModifier.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/3/3.
//

import SwiftUI

struct OnTapWithLocationViewModifier: ViewModifier {
    let callback: (CGPoint) -> Void
    @State private var location: CGPoint = .zero
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                callback(location)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { location = $0.location }
            )
    }
}

public extension View {
    func onTapGestureWithLocation(_ location: @escaping (CGPoint) -> Void) -> some View {
        modifier(OnTapWithLocationViewModifier(callback: location))
    }
}
