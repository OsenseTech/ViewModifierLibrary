//
//  ViewExtension.swift
//  NFTxAR
//
//  Created by 蘇健豪 on 2022/7/5.
//

import SwiftUI

extension View {
    public func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
