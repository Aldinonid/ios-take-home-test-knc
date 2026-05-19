//
//  TaskListViewModel.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class TaskListViewModel: ObservableObject {
    
    @Published var tasks: [TaskList] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: TaskListRepositoryProtocol
    
    init(repository: TaskListRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadTask(limit: Int = 20) async {
        guard tasks.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        do {
            tasks = try await repository.fetchTasks(limit: limit)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func toggleTask(_ taskId: Int) {
        guard let index = tasks.firstIndex(where: { $0.id == taskId }) else { return }
        
        tasks[index].completed.toggle()
        
        do {
            try repository.updateTaskCompletion(taskId: tasks[index].id,
                                                completed: tasks[index].completed)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}


extension TaskListViewModel {
    static func errorPreview() -> TaskListViewModel {
        let repo = MockTaskRepository()
        repo.shouldThrowError = true
        let vm = TaskListViewModel(repository: repo)
        vm.errorMessage = "Failed to load tasks"
        vm.isLoading = false
        return vm
    }
    
    static func successPreview() -> TaskListViewModel {
        let repo = MockTaskRepository()
        let vm = TaskListViewModel(repository: repo)
        vm.isLoading = false
        vm.tasks = [.mock(id: 1, completed: true),
                    .mock(id: 2, completed: false)]
        return vm
    }
}
