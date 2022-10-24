//
//  HideKeyboardModifier.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/3/21.
//

import SwiftUI

public extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
