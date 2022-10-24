//
//  NotFirstAppearModifier.swift
//  ObjectCaptureCamera
//
//  Created by 蘇健豪 on 2021/12/1.
//

import SwiftUI

struct NotFirstAppearModifier: ViewModifier {
    
    @State private var isFirstAppear = false
    private let action: (() -> Void)
    
    init(perform action: @escaping (() -> Void)) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if isFirstAppear == false {
                    isFirstAppear = true
                } else {
                    action()
                }
            }
    }
    
}

public extension View {
    func onNotFirstAppear(perform action: @escaping (() -> Void)) -> some View {
        modifier(NotFirstAppearModifier(perform: action))
    }
}
