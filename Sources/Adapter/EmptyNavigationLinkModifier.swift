//
//  EmptyNavigationLinkModifier.swift
//  Helper
//
//  Created by 蘇健豪 on 2022/2/8.
//

import SwiftUI

struct EmptyNavigationLinkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .if(.iOS14only) { view in
                view
                    .background(NavigationLink(destination: EmptyView(), label: {}))
            }
    }
}

public extension View {
    /**
     Handle SwiftUI's bug
     
     如果一個畫面有兩個 NavigationLink，在 push 進去之後又會馬上自動退出，目前測在 iOS 14.6, iOS 14.8.1 都會發生。
     
     Reference:
     
     [https://forums.swift.org/t/14-5-beta3-navigationlink-unexpected-pop/45279/2](https://forums.swift.org/t/14-5-beta3-navigationlink-unexpected-pop/45279/2)
     */
    @available(iOS, deprecated: 15, message: "This bug fixed in iOS 15.")
    func emptyNavigationLink() -> some View {
        modifier(EmptyNavigationLinkModifier())
    }
}
