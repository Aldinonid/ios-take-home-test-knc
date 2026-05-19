//
//  TaskRepository.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation

protocol TaskListRepositoryProtocol {
    func fetchTasks(limit: Int) async throws -> [TaskList]
    func updateTaskCompletion(taskId: Int, completed: Bool) throws
}

final class TaskListRepositoryImpl: TaskListRepositoryProtocol {
    
    private var tasks: [TaskList] = []
    private let networkService: NetworkService
    private let localDataSource: TaskLocalDataSource
    
    init(
        networkService: NetworkService,
        localDataSource: TaskLocalDataSource
    ) {
        self.networkService = networkService
        self.localDataSource = localDataSource
    }
    
    func fetchTasks(limit: Int) async throws -> [TaskList] {
        let data: [TaskList] = try await networkService.request(
            endpoint: TaskEndpoint.tasks)
        
        let overridesData = localDataSource.loadCompletionStates()
        
        return Array(data.prefix(limit)).map {
            TaskList(id: $0.id,
                     title: $0.title,
                     completed: overridesData[String($0.id)] ?? $0.completed)
        }
    }
    
    func updateTaskCompletion(taskId: Int, completed: Bool) throws {
        localDataSource.saveCompletion(taskId: taskId, completed: completed)
    }
}
