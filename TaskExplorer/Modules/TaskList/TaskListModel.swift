//
//  TaskListModel.swift
//  TaskExplorer
//
//  Created by Aldino Efendi on 2026/05/18.
//

import Foundation

struct TaskList: Identifiable, Equatable, Codable {
    let id: Int
    let title: String
    var completed: Bool
}
