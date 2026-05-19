//
//  MockTaskRepository.swift
//  TaskExplorerTests
//
//  Created by Aldino Efendi on 2026/05/19.
//

import Foundation

final class MockTaskRepository: TaskListRepositoryProtocol {
    
    var tasks: [TaskList] = []
    var fetchTaskCalled = false
    var updateCompletionCalled = false
    var shouldThrowError = false
    var delayInNanoseconds: UInt64 = 0
    
    func fetchTasks(limit: Int) async throws -> [TaskList] {
        fetchTaskCalled = true
        
        if delayInNanoseconds > 0 {
            try await Task.sleep(nanoseconds: delayInNanoseconds)
        }
        
        if shouldThrowError {
            throw NetworkError.serverError
        }
        
        return tasks
    }
    
    func updateTaskCompletion(taskId: Int, completed: Bool) throws {
        updateCompletionCalled = true
        
        if shouldThrowError {
            throw NetworkError.serverError
        }
        
        if let index = tasks.firstIndex(where: { $0.id == taskId }) {
            tasks[index].completed = completed
        }
    }
    
}
