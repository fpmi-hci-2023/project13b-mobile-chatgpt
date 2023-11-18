//
//  FindViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 14.11.23.
//

import Foundation

class FindViewModel: ObservableObject {
    @Published var filteredTasks: [Task] = []
    
    init() {
        filter(search: "")
    }
    
    func filter(search query: String){
        filteredTasks = APIManager.shared.allTasks.filter { task in
            query.isEmpty || task.name.lowercased().contains(query.lowercased())
        }
    }
    
    func changeStatus(id: String, newStatus: Int){
        guard let index = APIManager.shared.allTasks.firstIndex(where: { $0.id == id }) else { return }
        APIManager.shared.allTasks[index].status = newStatus
    }
    
    func removeTask(id: String) {
        guard let index = APIManager.shared.allTasks.firstIndex(where: { $0.id == id }) else { return }
        APIManager.shared.allTasks.remove(at: index)
    }
}
