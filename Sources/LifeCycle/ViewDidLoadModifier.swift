//
//  ViewDidLoadModifier.swift
//  ObjectCaptureCamera
//
//  Created by 蘇健豪 on 2021/11/26.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    
    @State private var viewDidLoad = false
    private let action: (() -> Void)
    
    init(perform action: @escaping (() -> Void)) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if viewDidLoad == false {
                viewDidLoad = true
                action()
            }
        }
    }
    
}

public extension View {
    func onLoad(perform action: @escaping (() -> Void)) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
