//
//  AlertModifier.swift
//  ObjectCaptureCamera
//
//  Created by 蘇健豪 on 2021/11/26.
//

import SwiftUI

struct AlertModifier: ViewModifier {

    var isPresented: Binding<Bool>
    let title: String
    let message: String
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .alert(title, isPresented: isPresented) {
                    Button("確定") {
                        action?()
                    }
                    
                    if action != nil {
                        Button(role: .cancel) {
                            
                        } label: {
                            Text("取消")
                        }
                    }
                } message: {
                    Text(message)
                }
        } else {
            content
                .alert(isPresented: isPresented) {
                    if action != nil {
                        return Alert(title: Text(title), message: Text(message), primaryButton: .default(Text("確定")) {
                            action?()
                        }, secondaryButton: .cancel())
                    } else {
                        return Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("確定")) {
                            action?()
                        })
                    }
                }
        }
    }
    
}

public extension View {
    func alertView(isPresented: Binding<Bool>, title: String, message: String, action: (() -> Void)? = nil) -> some View {
        modifier(AlertModifier(isPresented: isPresented, title: title, message: message, action: action))
    }
}
