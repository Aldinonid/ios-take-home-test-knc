//
//  TaskListViewModelTests.swift
//  TaskExplorerTests
//
//  Created by Aldino Efendi on 2026/05/19.
//

import XCTest
@testable import TaskExplorer

@MainActor
final class TaskListViewModelTests: XCTestCase {

    var mockRepo: MockTaskRepository!
    var vm: TaskListViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockTaskRepository()
        vm = TaskListViewModel(repository: mockRepo)
    }
    
    override func tearDown() {
        mockRepo = nil
        vm = nil
        super.tearDown()
    }

    func test_load_task_success() async throws {
        // Given
        mockRepo.tasks.append(.mock(title: "Mock Task", completed: false))
        
        // When
        await vm.loadTask()
        
        // Then
        XCTAssertTrue(mockRepo.fetchTaskCalled)
        XCTAssertEqual(vm.tasks.count, 1)
        XCTAssertEqual(vm.tasks.first?.title, "Mock Task")
        XCTAssertNil(vm.errorMessage)
    }

    func test_load_task_fail() async throws {
        // Given
        mockRepo.shouldThrowError = true
        
        // When
        await vm.loadTask()
        
        // Then
        XCTAssertTrue(vm.tasks.isEmpty)
        XCTAssertNotNil(vm.errorMessage)
    }
    
    func test_toggle_task() async throws {
        // Given
        mockRepo.tasks.append(.mock(completed: false))
        await vm.loadTask()
        
        // When
        vm.toggleTask(1)
        
        // Then
        XCTAssertTrue(mockRepo.updateCompletionCalled)
        XCTAssertTrue(mockRepo.tasks[0].completed)
    }
    
    func test_load_tasks_loading_state() async {
        // Given
        mockRepo.delayInNanoseconds = 3_000_000
        mockRepo.tasks.append(.mock())
        
        // When
        let task = Task {
            await vm.loadTask()
        }
        
        try? await Task.sleep(nanoseconds: 50_000_000)
        
        // Then
        XCTAssertTrue(vm.isLoading)
        await task.value
        XCTAssertFalse(vm.isLoading)
    }
    
    func test_load_task_empty_result() async {
        // Given
        mockRepo.tasks = []
        
        // When
        await vm.loadTask()
        
        // Then
        XCTAssertTrue(vm.tasks.isEmpty)
        XCTAssertNil(vm.errorMessage)
    }
    
    func test_toggle_task_updated_correct_task() async {
        // Given
        mockRepo.tasks = [.mock(id: 1, completed: false),
                          .mock(id: 2, completed: false)]
        
        // When
        await vm.loadTask()
        
        vm.toggleTask(2)
        
        // Then
        XCTAssertFalse(vm.tasks[0].completed)
        XCTAssertTrue(vm.tasks[1].completed)
    }
    
    func test_toggle_task_invalid() async {
        // Given
        mockRepo.tasks = [.mock(id: 1, completed: false)]
        
        // When
        await vm.loadTask()
        vm.toggleTask(999)
        
        // Then
        XCTAssertFalse(vm.tasks[0].completed)
    }
    
    func test_error_message_cleared_after_success() async {
        // Given
        mockRepo.shouldThrowError = true
        await vm.loadTask()
        XCTAssertNotNil(vm.errorMessage)
        mockRepo.shouldThrowError = false
        mockRepo.tasks = [.mock()]
        
        // When
        await vm.loadTask()
        
        // Then
        XCTAssertNil(vm.errorMessage)
        XCTAssertEqual(vm.tasks.count, 1)
    }

}
