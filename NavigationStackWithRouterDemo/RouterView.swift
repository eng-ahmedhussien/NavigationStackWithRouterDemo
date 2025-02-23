//
//  RouterView.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
              
                .navigationDestination(for: Router.Destination.self) { route in
                    router.view(for: route)
                }
                .fullScreenCover(item: $router.presentedView) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}
