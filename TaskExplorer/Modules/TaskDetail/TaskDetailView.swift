//
//  TaskDetailView.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/19.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Binding var task: TaskList
    
    var body: some View {
        VStack(spacing: 24) {
            Text(task.title)
            Button {
                task.completed.toggle()
            } label: {
                Label(
                    task.completed
                    ? "Completed"
                    : "Incomplete",
                    systemImage:
                        task.completed
                        ? "checkmark.circle.fill"
                        : "circle"
                )
                .foregroundStyle(task.completed ? .green : .gray)
            }
        }
        .padding()
        .navigationTitle(task.title)
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(task: .constant(TaskList(id: 1, title: "Buy a Groceries", completed: false)))
    }
}
