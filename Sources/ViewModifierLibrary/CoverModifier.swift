//
//  CoverModifier.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/10.
//

import SwiftUI

struct CoverModifier<CoverView: View>: ViewModifier {
    @ViewBuilder var coverView: () -> CoverView
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .overlay {
                    coverView()
                }
        } else {
            content
                .overlay(coverView())
        }
    }
}

public extension View {
    func cover<V: View>(@ViewBuilder _ coverView: @escaping () -> V) -> some View {
        modifier(CoverModifier(coverView: coverView))
    }
}
