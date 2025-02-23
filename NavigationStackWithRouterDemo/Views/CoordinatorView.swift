//
//  CoordinatorView.swift
//  CoordinatorPatternSample
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject var appCoordinator: AppCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
           // TapBarView()
            appCoordinator.build(.tapbar)
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
                .sheet(item: $appCoordinator.sheetView) { sheet in
                    appCoordinator.build(sheet)
                }
                .fullScreenCover(item: $appCoordinator.fullScreen) { fullScreen in
                    appCoordinator.build(fullScreen)
                }
                .navigationTitle("Coordinator Pattern")
        }
        .environmentObject(appCoordinator)
    }
}

#Preview {
    CoordinatorView()
}
