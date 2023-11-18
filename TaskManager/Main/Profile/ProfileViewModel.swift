//
//  ProfileViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 14.11.23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var photo: String = ""
    @Published var name: String = ""
    @Published var about: String = ""
    @Published var phone: String = ""
    @Published var email: String = ""
    
    init() {
        getUserInfo()
    }
    
    func getUserInfo() {
        photo = "person.fill"
        name = "Someone"
        about = "Some information"
        phone = "(555) 123-4567"
        email = "someone@gmail.com"
    }
}
