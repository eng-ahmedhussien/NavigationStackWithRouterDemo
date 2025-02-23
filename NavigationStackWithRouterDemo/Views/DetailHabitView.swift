//
//  DetailHabitView.swift
//  CoordinatorPatternSample
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct DetailHabitView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    let habit: Habit
    
    var body: some View {
        VStack {
            List(habit.tasks) { task in
                Button {
                    appCoordinator.presentSheet(.detailTask(named: task))
                } label: {
                    Text(task.title)
                }
            }
        }
        .navigationTitle(habit.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Home") {
                    appCoordinator.popToRoot()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailHabitView(habit: .habitsDummy[0])
    }
}
