//
//  TaskRepository.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation

protocol TaskListRepositoryProtocol {
    func fetchTasks() async throws -> [TaskList]
    func updateTaskCompletion(_ taskId: Int, completed: Bool) throws
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
    
    func fetchTasks() async throws -> [TaskList] {
        let data = try await networkService.request(
            endpoint: TaskEndpoint.tasks,
            type: [TaskList].self)
        
        let overridesData = localDataSource.loadCompletionStates()
        
        return data.map {
            TaskList(id: $0.id,
                     title: $0.title,
                     completed: overridesData[String($0.id)] ?? $0.completed)
        }
    }
    
    func updateTaskCompletion(_ taskId: Int, completed: Bool) throws {
        localDataSource.saveCompletion(taskId: taskId, completed: completed)
    }
}
