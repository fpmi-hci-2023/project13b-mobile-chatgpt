//
//  LogInViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import Foundation

enum LoginError: Error {
    case badUsername
    case badEmail
    case badPassword

    var errorMessage: String {
        switch self {
        case .badUsername:
            return "Wrong Username"
        case .badEmail:
            return "Wrong Email"
        case .badPassword:
            return "Wrong Password"
        }
    }
}

class LogInViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var result: Result<String, LoginError>?

    func tryLogin() {
        result = .success("Nice!")
//        result = .failure(.badEmail)
    }
}
