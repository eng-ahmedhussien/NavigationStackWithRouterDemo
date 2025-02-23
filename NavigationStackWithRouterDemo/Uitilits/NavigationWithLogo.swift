//
//  NavigationWithLogo.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 23/02/2025.
//

import SwiftUI


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
