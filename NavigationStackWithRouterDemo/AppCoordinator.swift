//
//  Router.swift
//  NavigationStackWithRouterDemo
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheetView: SheetView? { get set }
    var fullScreen: FullScreen? { get set }

    func push(_ screen:  Screen)
    func presentSheet(_ sheet: SheetView)
    func presentFullScreenCover(_ fullScreenCover: FullScreen)
    func pop()
    func popToRoot()
    func dismissSheet()
    func dismissFullScreenOver()
}

class AppCoordinator : AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheetView: SheetView?
    @Published var fullScreen: FullScreen?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pushView<V: View>(_ view: V) {
        let container = AnyViewContainer(view: AnyView(view))
        path.append(container)
    }
    
    func presentSheet(_ sheet: SheetView) {
        self.sheetView = sheet
    }
    
    func presentFullScreenCover(_ fullScreen: FullScreen) {
        self.fullScreen = fullScreen
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheetView = nil
    }
    
    func dismissFullScreenOver() {
        self.fullScreen = nil
    }
    
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case.tapbar:
            TapBarView()
        case .home:
            HomeView()
        case .listHabit:
            ListHabitView()
        case .detailHabit(named: let habit):
            DetailHabitView(habit: habit)
        }
    }
    
    @ViewBuilder
    func build(_ sheet: SheetView) -> some View {
        switch sheet {
        case .detailTask(named: let task):
            DetailTaskView(task: task)
        }
    }
    
    @ViewBuilder
    func build(_ fullScreenCover: FullScreen) -> some View {
        switch fullScreenCover {
        case .addHabit(onSaveButtonTap: let onSaveButtonTap):
            AddHabitView(onSaveButtonTap: onSaveButtonTap)
        }
    }

}

// MARK: - enums

enum Screen: Identifiable, Hashable {
    case tapbar
    case home
    case listHabit
    case detailHabit(named: Habit)
    
    var id: Self { return self }
}

enum SheetView: Identifiable, Hashable {
    case detailTask(named: Task)
    
    var id: Self { return self }
}

enum FullScreen: Identifiable, Hashable {
    case addHabit(onSaveButtonTap: ((Habit) -> Void))

    var id: Self { return self }
}

extension FullScreen {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .addHabit:
            hasher.combine("addHabit")
        }
    }
    
    // Conform to Equatable
    static func == (lhs: FullScreen, rhs: FullScreen) -> Bool {
        switch (lhs, rhs) {
        case (.addHabit, .addHabit):
            return true
        }
    }
}

// Wrapper for Any View Navigation
struct AnyViewContainer: Identifiable, Hashable {
    let id = UUID()
    let view: AnyView
    
    static func == (lhs: AnyViewContainer, rhs: AnyViewContainer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
