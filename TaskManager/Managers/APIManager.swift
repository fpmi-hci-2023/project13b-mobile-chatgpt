//
//  APIManager.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 14.11.23.
//

import Foundation

final class APIManager: ObservableObject {
    @Published var allTasks: [Task] = []

    static let shared = APIManager()

    private init() {
        allTasks = getTasks()
    }

    func getTasks() -> [Task] {
        let testTasks = [
            Task(coordinators: ["Artyom", "Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Artyom", name: "Test 1", next: 1, status: 0, date: Date() - 1),
            Task(coordinators: ["Artyom"], description: "Some description", id: UUID().uuidString, initiator: "Pavel", name: "Test 2", next: 2, status: 0, date:  Date() - 2),
            Task(coordinators: ["Richard"], description: "Some description", id: UUID().uuidString, initiator: "Richard", name: "Test 3", next: 4, status: 1, date:  Date()),
            Task(coordinators: ["Ilya"], description: "Some description", id: UUID().uuidString, initiator: "Pavel", name: "Test 4", next: 5, status: 1, date:  Date() - 5),
            Task(coordinators: ["Ilya", "Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Ilya", name: "Test 5", next: 6, status: 2, date:  Date() - 1),
            Task(coordinators: ["Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Richard", name: "Test 6", next: -1, status: 2, date: Date())
        ]

        return testTasks
    }
}
