//
//  ScrollDirectionModifier.swift
//  
//
//  Created by 蘇健豪 on 2022/7/1.
//

import SwiftUI

public enum Direction {
    case up
    case down
}

struct ScrollDirectionModifier: ViewModifier {
    
    let callback: (Direction) -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture()
                    .onChanged { gesture in
                        let xShift = abs(gesture.location.x - gesture.predictedEndLocation.x)
                        let yShift = abs(gesture.location.y - gesture.predictedEndLocation.y)
                        guard yShift > xShift else { return }
                        
                        if (gesture.location.y > gesture.predictedEndLocation.y) {
                            callback(.up)
                        } else {
                            callback(.down)
                        }
                    }
            )
    }
    
}

public extension View {
    func onScrollDirection(callback: @escaping (Direction) -> Void) -> some View {
        modifier(ScrollDirectionModifier(callback: callback))
    }
}

