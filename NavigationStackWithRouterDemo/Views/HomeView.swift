//
//  HomeView.swift
//  CoordinatorPatternSample
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(systemName: "house")
                .foregroundStyle(.tint)
                .imageScale(.large)
            
            Text("Home")
            
            Spacer()
            
            Button("Go to Habit List") {
                appCoordinator.push(.listHabit)
            }
            
            Spacer()
        }
        .navigationTitle("Home")
        
    }
}

#Preview {
    HomeView()
}
