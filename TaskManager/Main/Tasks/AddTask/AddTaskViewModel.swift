//
//  AddTaskViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 18.11.23.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    func addTask(task: Task) {
        APIManager.shared.allTasks.append(task)
    }
}
