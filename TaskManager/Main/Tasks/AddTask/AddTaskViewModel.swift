//
//  AddTaskViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 18.11.23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    func addTask(task: TaskModel) {
        APIManager.shared.addTask(coordinators: task.coordinators, description: task.description, name: task.name)
    }
}
