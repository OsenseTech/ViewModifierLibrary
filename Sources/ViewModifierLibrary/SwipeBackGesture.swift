//
//  SwipeBackGesture.swift
//  NFTxAR
//
//  Created by 蘇健豪 on 2022/9/23.
//

import SwiftUI

// Native
extension UINavigationController: UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
    
}

// Deal with simultaneousGesture problem
struct SwipeBackGesture: ViewModifier {
    
    @GestureState private var dragOffset: CGSize = .zero
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture()
                    .updating($dragOffset) { (value, state, transaction) in
                        if (value.startLocation.x < 20 && value.translation.width > 100) {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
            )
    }
    
}

public extension View {
    func swipBackGestureEnable() -> some View {
        modifier(SwipeBackGesture())
    }
}
