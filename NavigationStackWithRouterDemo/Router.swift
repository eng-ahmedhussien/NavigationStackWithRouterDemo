//
//  Router.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

class Router: ObservableObject {
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var presentedView: Destination?
    
    enum Destination: Hashable, Identifiable {
        case viewA
        case viewB(String)
        case viewC
        case SheetView
        
        var id: String {
            String(describing: self)
        }
    }
    
    @ViewBuilder func view(for route: Destination) -> some View {
        switch route {
        case .viewA:
            ViewA()
        case .viewB(let str):
            ViewB(description: str)
        case .viewC:
            ViewC()
        case .SheetView:
            SheetView()
        }
    }
    
    func navigateTo(_ appRoute: Destination) {
        path.append(appRoute)
    }
    
    func navigateBack() {
        guard !path.isEmpty else { return }
           path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func showView(_ appRoute: Destination) {
        presentedView = appRoute
    }
    
    func dismissPresentedView() {
        presentedView = nil
    }
}

struct NavigationBarWithLogoModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "square.and.arrow.up.fill")
                }
            }.padding(.bottom,0)
    }
}

extension View {
    func navigationBarWithLogo() -> some View {
        self.modifier(NavigationBarWithLogoModifier())
    }
}

