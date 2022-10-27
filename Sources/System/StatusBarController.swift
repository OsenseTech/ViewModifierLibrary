//
//  StatusBarController.swift
//  Insert this into your project.
//  Created by Xavier Donnellon
//

import SwiftUI

class HostingController<Content: View>: UIHostingController<Content> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.statusBarStyle
    }
}

///By wrapping views in a RootView, they will become the app's main / primary view. This will enable setting the statusBarStyle.
public struct RootView<Content: View>: View {
    var content: Content
    
    public init(@ViewBuilder content: () -> (Content)) {
        self.content = content()
    }
    
    public var body: some View {
        EmptyView()
            .onAppear {
                UIApplication.shared.setHostingController(rootView: AnyView(content))
            }
    }
}

@available(iOS 16.0, *)
public struct StatusBarStyleModifier: ViewModifier {
    
    public let statusBarStyle: ColorScheme
    public var visibility: Visibility
    
    public init(statusBarStyle: ColorScheme, visibility: Visibility = .visible) {
        self.statusBarStyle = statusBarStyle
        self.visibility = visibility
    }
    
    public func body(content: Content) -> some View {
        content
            .toolbarBackground(visibility, for: .navigationBar)
            .toolbarColorScheme(statusBarStyle, for: .navigationBar)
    }
}

public extension View {
    ///Sets the status bar style color for this view.
    func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        if #available(iOS 16.0, *) {
            let colorScheme: ColorScheme
            switch style {
                case .lightContent:
                    colorScheme = .light
                case .darkContent:
                    colorScheme = .dark
                default:
                    colorScheme = .light
            }
            
            return modifier(StatusBarStyleModifier(statusBarStyle: colorScheme))
        } else {
            UIApplication.statusBarStyleHierarchy.append(style)
            //Once this view appears, set the style to the new style. Once it disappears, set it to the previous style.
            return self.onAppear {
                UIApplication.setStatusBarStyle(style)
            }.onDisappear {
                guard UIApplication.statusBarStyleHierarchy.count > 1 else { return }
                let style = UIApplication.statusBarStyleHierarchy[UIApplication.statusBarStyleHierarchy.count - 1]
                UIApplication.statusBarStyleHierarchy.removeLast()
                UIApplication.setStatusBarStyle(style)
            }
        }
    }
    
    @available(iOS 16.0, *)
    func setStatusBarStyleiOS16(_ style: UIStatusBarStyle, visibility: Visibility) -> some View {
        let colorScheme: ColorScheme
        switch style {
            case .lightContent:
                colorScheme = .light
            case .darkContent:
                colorScheme = .dark
            default:
                colorScheme = .light
        }
        
        return modifier(StatusBarStyleModifier(statusBarStyle: colorScheme, visibility: visibility))
    }
    
    func setStatusBarStyleiOS15(_ style: UIStatusBarStyle) -> some View {
        UIApplication.statusBarStyleHierarchy.append(style)
        //Once this view appears, set the style to the new style. Once it disappears, set it to the previous style.
        return self.onAppear {
            UIApplication.setStatusBarStyle(style)
        }.onDisappear {
            guard UIApplication.statusBarStyleHierarchy.count > 1 else { return }
            let style = UIApplication.statusBarStyleHierarchy[UIApplication.statusBarStyleHierarchy.count - 1]
            UIApplication.statusBarStyleHierarchy.removeLast()
            UIApplication.setStatusBarStyle(style)
        }
    }
}

extension UIApplication {
    static var hostingController: HostingController<AnyView>? = nil
    
    static var statusBarStyleHierarchy: [UIStatusBarStyle] = []
    static var statusBarStyle: UIStatusBarStyle = .darkContent
    
    ///Sets the App to start at rootView
    func setHostingController(rootView: AnyView) {
        let hostingController = HostingController(rootView: AnyView(rootView))
        windows.first?.rootViewController = hostingController
        UIApplication.hostingController = hostingController
    }
    
    static func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        hostingController?.setNeedsStatusBarAppearanceUpdate()
    }
}
