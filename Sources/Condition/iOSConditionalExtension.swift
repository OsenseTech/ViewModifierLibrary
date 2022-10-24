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
    
    static var iOS14_5: Bool {
        if #available(iOS 14.5, *) {
            return true
        } else {
            return false
        }
    }
    
    static var iOS14_3: Bool {
        if #available(iOS 14.3, *) {
            return true
        } else {
            return false
        }
    }
    
    static var iOS14: Bool {
        if #available(iOS 14, *) {
            return true
        } else {
            return false
        }
    }
    
    static var iOS14only: Bool {
        let os = ProcessInfo().operatingSystemVersion
        
        switch (os.majorVersion, os.minorVersion, os.patchVersion) {
        case (let x, _, _) where x < 15:
            return true
        default:
            return false
        }
    }

}
