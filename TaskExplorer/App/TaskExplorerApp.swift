//
//  TaskExplorerApp.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import SwiftUI

@main
struct TaskExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TaskListView(vm: makeTaskListViewModel())
            }
        }
    }
    
    private func makeTaskListViewModel() -> TaskListViewModel {
        let networkService = URLSessionNetworkService()
        let localDataSource = UserDefaultsDataSource()
        let repository = TaskListRepositoryImpl(
            networkService: networkService,
            localDataSource: localDataSource
        )
        
        return TaskListViewModel(repository: repository)
    }
}
