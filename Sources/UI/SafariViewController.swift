//
//  SafariViewController.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/1/19.
//

import SwiftUI
import SafariServices

struct SafariViewController: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewController>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewController>) {
        
    }
    
}
