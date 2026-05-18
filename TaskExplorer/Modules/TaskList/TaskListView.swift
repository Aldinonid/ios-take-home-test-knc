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
                        TaskDetailView(task: $task)
                    } label: {
                        TaskRowView(
                            task: task,
                            onToggle: {
                                vm.toggleTaskCompletion(task)
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

final class MockTaskRepository: TaskListRepositoryProtocol {
    
    var tasks: [TaskList] = [
        TaskList(id: 1, title: "Buy groceries", completed: false),
        TaskList(id: 2, title: "Finish take home test", completed: true)
    ]
    
    func fetchTasks() async throws -> [TaskList] { tasks }
    
    func updateTaskCompletion(_ taskId: Int, completed: Bool) throws {
        
    }
    
}


#Preview {
    TaskListView(vm: TaskListViewModel(repository: MockTaskRepository()))
}
