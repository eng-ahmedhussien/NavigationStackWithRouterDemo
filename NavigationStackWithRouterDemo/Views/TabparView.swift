//
//  TabparView.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct TapBarView: View {
    
    @State var selectionTap: TabBarItem = .home
    
    init() {
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor
            ]
        )
        let appearance = UITabBarAppearance()
       // appearance.configureWithTransparentBackground()
      appearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor(.red)
       appearance.backgroundColor =  UIColor(.white)
        appearance.shadowImage = image
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
    }
    
    var body: some View {
        
        TabView(selection: $selectionTap) {

            CustomTabItem(imageName: "house.fill",
                          title:
                            "HomeTapBar",
                          tag: TabBarItem.home) {
                HomeView()
            }
            
            CustomTabItem(imageName: "server.rack", title:"servicesTapBar", tag: TabBarItem.services) {
                ListHabitView()
            }
        }
        .accentColor(.black)
        
        
    }
}

//MARK: - CustomTabItem
struct CustomTabItem<Content: View>: View {
    var imageName: String
    var title: String
    var tag: TabBarItem
    var content: Content
    
    init(imageName: String, title: String,tag: TabBarItem,@ViewBuilder content: () -> Content) {
        self.imageName = imageName
        self.title = title
        self.tag = tag
        self.content = content()
    }
    
    var body: some View {
        content
            .tabItem {
                VStack {
                    Image(systemName: imageName)
                    Text(title)
                }
            }
            .tag(tag)
            //.navigationTitle(title)
    }
}

extension UIImage {
    static func gradientImageWithBounds(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

enum TabBarItem: Int, Hashable {
    case home = 0
    case services = 1
    case cart = 2
    
    var imageName: String{
        switch self {
        case .home:
            return  "house.fill"
        case .services:
            return  "server.rack"
        case .cart:
            return  "cart.fill"
        }
    }
    
    var title: String{
        switch self {
        case .home:
            return  "HomeTapBar"
        case .services:
            return  "servicesTapBar"
        case .cart:
            return  "cartTapBar"
        }
    }
}

#Preview {
    TapBarView()
}
