//
//  TaskListView.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject private var vm: TaskListViewModel
    
    init(vm: TaskListViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Group {
            if vm.isLoading {
                ProgressView("Loading Tasks...")
            } else if let error = vm.errorMessage {
                ErrorView(
                    message: error,
                    retryAction: {
                        Task {
                            await vm.loadTask()
                        }
                    }
                )
            } else {
                List($vm.tasks) { $task in
                    NavigationLink {
                        TaskDetailView(
                            task: $task,
                            onToggle: {
                                vm.toggleTask(task.id)
                            }
                        )
                    } label: {
                        TaskRowView(
                            task: task,
                            onToggle: {
                                vm.toggleTask(task.id)
                            }
                        )
                    }
                }
            }
        }
        .navigationTitle("Task Explorer")
        .task {
            await vm.loadTask()
        }
    }
}

struct TaskRowView: View {
    let task: TaskList
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
            }
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(task.completed ? .green : .gray)
            }
            .buttonStyle(.borderless)
        }
    }
}


#Preview("Success") {
    NavigationStack {
        TaskListView(vm: .successPreview())
    }
}

#Preview("Error State") {
    NavigationStack {
        TaskListView(vm: .errorPreview())        
    }
}
