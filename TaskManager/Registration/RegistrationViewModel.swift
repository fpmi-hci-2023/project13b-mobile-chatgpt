//
//  RegistrationViewModel.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import Foundation

enum RegistrationError: Error, Equatable {
    case badUsername
    case badEmail
    case badPassword
    case unknown(String)

    var errorMessage: String {
        switch self {
        case .badUsername:
            return "Wrong Username"
        case .badEmail:
            return "Wrong Email"
        case .badPassword:
            return "Wrong Password"
        case .unknown(let message):
            return "Something went wrong: \(message)"
        }
    }
}

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var result: Result<String, RegistrationError>?

    func tryRegister() {
        APIManager.shared.register(username: username, email: email, password: password) { error in
            DispatchQueue.main.async {
                self.result = error == nil ? .success("Nice!") : .failure(.unknown(error!))
            }
        }
    }
}
