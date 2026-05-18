//
//  UserDefaultsDataSource.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation

protocol TaskLocalDataSource {
    func loadCompletionStates() -> [String: Bool]
    func saveCompletion(taskId: Int, completed: Bool)
}

final class UserDefaultsDataSource: TaskLocalDataSource {
    
    private let key = "task_completion"
    
    func loadCompletionStates() -> [String: Bool] {
        UserDefaults.standard.dictionary(forKey: key) as? [String: Bool] ?? [:]
    }
    
    func saveCompletion(taskId: Int, completed: Bool) {
        var states = loadCompletionStates()
        states[String(taskId)] = completed
        UserDefaults.standard.set(states, forKey: key)
    }
    
}
