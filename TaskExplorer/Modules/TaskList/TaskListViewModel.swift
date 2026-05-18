//
//  TaskListViewModel.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation
import Combine

@MainActor
final class TaskListViewModel: ObservableObject {
    
    @Published var tasks: [TaskList] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: TaskListRepositoryProtocol
    
    init(repository: TaskListRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadTask() async {
        guard tasks.isEmpty else { return }
        isLoading = true
        try? await Task.sleep(for: .seconds(5))
        errorMessage = nil
        do {
            tasks = try await repository.fetchTasks()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func toggleTaskCompletion(_ task: TaskList) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        
        tasks[index].completed.toggle()
        
        do {
            try repository.updateTaskCompletion(task.id, completed: tasks[index].completed)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}
