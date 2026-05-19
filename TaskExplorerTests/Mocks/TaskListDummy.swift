//
//  TaskListDummy.swift
//  TaskExplorerTests
//
//  Created by Aldino Efendi on 2026/05/19.
//

import Foundation

extension TaskList {
    static func mock(
        id: Int = 1,
        title: String = "Mock Task",
        completed: Bool = false
    ) -> TaskList {
        TaskList(id: id, title: title, completed: completed)
    }
}
