//
//  DetailTaskView.swift
//  CoordinatorPatternSample
//
//  Created by ahmed hussien on 27/01/2025.
//

import SwiftUI

struct DetailTaskView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    let task: Task
    
    var body: some View {
        NavigationStack {
            List {
                Text(task.title)
                    .font(.headline)
                
                Text(task.description)
                    .foregroundStyle(.secondary)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        appCoordinator.dismissSheet()
                    }
                }
            }
        }
    }
}

#Preview {
    DetailTaskView(task: Habit.habitsDummy[0].tasks[0])
}
