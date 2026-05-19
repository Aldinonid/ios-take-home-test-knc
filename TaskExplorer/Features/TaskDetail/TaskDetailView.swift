//
//  TaskDetailView.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/19.
//

import SwiftUI

struct TaskDetailView: View {
    
    @Binding var task: TaskList
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 12) {
                Text(task.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                HStack(spacing: 8) {
                    Circle()
                        .fill(task.completed ? .green : .gray)
                        .frame(width: 10, height: 10)
                    
                    Text(task.completed ? "Compleded" : "Incomplete")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
            }
            Button(action: onToggle) {
                Text("Mark as \(task.completed ? "Incomplete" : "Complete")")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Task Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(
            task: .constant(TaskList(id: 1, title: "Buy a Groceries", completed: false)),
            onToggle: {}
        )
    }
}
