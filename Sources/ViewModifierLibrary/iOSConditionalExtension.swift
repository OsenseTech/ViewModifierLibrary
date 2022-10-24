//
//  iOSConditionalExtension.swift
//  NFTxAR
//
//  Created by 蘇健豪 on 2022/10/5.
//

import Foundation

public extension Bool {
    
    static var iOS16: Bool {
        if #available(iOS 16, *) {
            return true
        } else {
            return false
        }
    }
    
    static var iOS15: Bool {
        if #available(iOS 15, *) {
            return true
        } else {
            return false
        }
    }
    
}
