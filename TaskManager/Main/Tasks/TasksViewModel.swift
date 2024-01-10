//
//  TasksViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import Foundation

class TasksViewModel: ObservableObject {
    @Published var tasksToShow: [Task] = []

    init() {
        updateTasksToShow(for: 0)
    }

    func updateTasksToShow(for status: Int) {
//        allTasks = APIManager.shared.allTasks
        tasksToShow = APIManager.shared.allTasks.filter({ $0.status == status })
    }

    func changeStatus(id: String, newStatus: Int) {
        guard let index = APIManager.shared.allTasks.firstIndex(where: { $0.id == id }) else { return }
        APIManager.shared.allTasks[index].status = newStatus
        if newStatus == 1 {
            APIManager.shared.approveTask(coordinator: APIManager.shared.userInfo!.username, taskId: id)
        } else if newStatus == 2 {
            APIManager.shared.declineTask(coordinator: APIManager.shared.userInfo!.username, taskId: id)
        }
    }

    func removeTask(id: String) {
        guard let index = APIManager.shared.allTasks.firstIndex(where: { $0.id == id }) else { return }
        APIManager.shared.allTasks.remove(at: index)
        APIManager.shared.deleteTask(with: id)
    }
}
