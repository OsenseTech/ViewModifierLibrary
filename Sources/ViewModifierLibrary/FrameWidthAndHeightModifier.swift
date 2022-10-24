//
//  FrameWidthAndHeightModifier.swift
//  
//
//  Created by 蘇健豪 on 2022/6/24.
//

import SwiftUI

struct FrameWidthAndHeightModifier: ViewModifier {
    let length: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: length, height: length)
    }
}

public extension View {
    func frame(widthAndHeight length: CGFloat) -> some View {
        modifier(FrameWidthAndHeightModifier(length: length))
    }
}
