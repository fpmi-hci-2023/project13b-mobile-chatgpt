//
//  Task.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import Foundation

struct Task: Codable, Equatable {
    init(coordinators: [String], description: String, id: String, initiator: String, name: String, next: Int, status: Int, date: Date) {
        self.coordinators = coordinators
        self.description = description
        self.id = id
        self.initiator = initiator
        self.name = name
        self.next = next
        self.status = status
        self.date = date
    }
    
    init() {
        self.coordinators = []
        self.description = ""
        self.id = UUID().uuidString
        self.initiator = ""
        self.name = ""
        self.next = 0
        self.status = 0
        self.date = Date()
    }
    
    var coordinators: [String]
    var description: String
    var id: String
    var initiator: String
    var name: String
    var next: Int
    var status: Int
    
    var date: Date
}

struct Tasks: Codable {
    var tasks: [Task]
}
