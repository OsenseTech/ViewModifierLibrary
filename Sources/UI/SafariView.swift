//
//  SafariView.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/2/7.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SafariView: View {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        SafariViewController(url: url)
            .ignoresSafeArea()
    }
}

@available(iOS 14.0, *)
struct SafariView_Previews: PreviewProvider {
    static var previews: some View {
        SafariView(url: URL(string: "")!)
    }
}
