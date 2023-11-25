//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by Artem Shuneyko on 18.11.23.
//

import XCTest
@testable import TaskManager

final class TaskManagerTests: XCTestCase {
    
    let manager = APIManager.shared
    var addTaskViewmodel: AddTaskViewModel?
    var tasksViewModel: TasksViewModel?
    var findViewModel: FindViewModel?

    override func setUpWithError() throws {
        addTaskViewmodel = AddTaskViewModel()
        tasksViewModel = TasksViewModel()
        findViewModel = FindViewModel()
    }

    override func tearDownWithError() throws {
        addTaskViewmodel = nil
        tasksViewModel = nil
        findViewModel = nil
        
        try super.tearDownWithError()
    }

    func testAddTask() throws {
        XCTAssert(manager.allTasks.count > 0)
        
        let countBeforeAdd = manager.allTasks.count
        let testTask = Task()
        
        addTaskViewmodel?.addTask(task: testTask)
        
        XCTAssert(manager.allTasks.count == countBeforeAdd + 1)
    }
    
    func testRemoveTask() throws {
        XCTAssert(manager.allTasks.count > 0)
        
        let countBeforeRemove = manager.allTasks.count
        let testTask = manager.allTasks.last!
        
        tasksViewModel?.removeTask(id: testTask.id)
        
        XCTAssert(manager.allTasks.count == countBeforeRemove - 1)
    }
    
    func testChangeStatus() throws {
        XCTAssert(manager.allTasks.count > 0)
        
        let testTask = manager.allTasks.last!
        let status = testTask.status
        let newStatus = status == 2 ? 0 : status + 1
        
        tasksViewModel?.changeStatus(id: testTask.id, newStatus: newStatus)
        let updatedTestTask = manager.allTasks.first(where: { $0.id == testTask.id })!
        
        XCTAssert(updatedTestTask.status != status)
        XCTAssert(updatedTestTask.status == newStatus)
    }
    
    func testFilerById() throws {
        XCTAssert(manager.allTasks.count > 0)
        
        let countBeforeFilter = manager.allTasks.count
        
        tasksViewModel?.updateTasksToShow(for: 0)
        let filterdTasksCount = tasksViewModel?.tasksToShow.count
        
        XCTAssert(countBeforeFilter != filterdTasksCount)
    }
    
    func testFilerByQuery() throws {
        XCTAssert(manager.allTasks.count > 0)
        
        let countBeforeFilter = manager.allTasks.count
        
        findViewModel?.filter(search: "1")
        let filterdTasksCount = findViewModel?.filteredTasks.count
        
        XCTAssert(countBeforeFilter != filterdTasksCount)
    }

}
