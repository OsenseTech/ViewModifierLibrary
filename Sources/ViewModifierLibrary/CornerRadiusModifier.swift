//
//  CornerRadiusModifier.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/6.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension UIRectCorner {
    static let top: UIRectCorner = [.topLeft, .topRight]
    static let bottom: UIRectCorner = [.bottomLeft, .bottomRight]
    static let right: UIRectCorner = [.topRight, .bottomRight]
    static let left: UIRectCorner = [.topLeft, .bottomLeft]
}

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
