//
//  APIManager.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 14.11.23.
//

import Foundation

final class APIManager: ObservableObject {
    @Published var allTasks: [TaskModel] = []
    @Published var userInfo: UserInfoModel?

    static let shared = APIManager()

    private init() {
        getTasks()
    }

    func logout() {
        let url = URL(string: "https://auth.hci.richardhere.dev/api/v1/logout")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print(httpResponse.statusCode)
            }

            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }

        task.resume()

    }

    func login(username: String, email: String, password: String, complition: @escaping (String?) -> Void) {

        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        let url = URL(string: "https://auth.hci.richardhere.dev/api/v1/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                complition(error.localizedDescription)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print(httpResponse.statusCode)
            }

            if let data = data {
                print(String(data: data, encoding: .utf8)!)

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let responseDict = json as? [String: Any],
                       let email = responseDict["email"] as? String,
                       let lastLogin = responseDict["lastLogin"] as? String,
                       let username = responseDict["username"] as? String {
                        print("Email: \(email)")
                        print("Last Login: \(lastLogin)")
                        print("Username: \(username)")

                        DispatchQueue.main.async { [weak self] in
                            self?.userInfo = UserInfoModel(email: email, username: username)
                            complition(nil)
                        }
                    } else {
                        print("Invalid response format")
                        complition(String(data: data, encoding: .utf8)!)
                    }
                } catch {
                    print("Error parsing JSON data: \(error)")
                    complition(error.localizedDescription)
                }
            }
        }

        task.resume()
    }

    func register(username: String, email: String, password: String, complition: @escaping (String?) -> Void) {
        let url = URL(string: "https://auth.hci.richardhere.dev/api/v1/reg")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "username": username
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            complition(error.localizedDescription)
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                complition(error.localizedDescription)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print(httpResponse.statusCode)
            }

            if let data = data {
                print(String(data: data, encoding: .utf8)!)

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let responseDict = json as? [String: Any],
                       let email = responseDict["email"] as? String,
                       let username = responseDict["username"] as? String {
                        print("Email: \(email)")
                        print("Username: \(username)")

                        DispatchQueue.main.async { [weak self] in
                            self?.userInfo = UserInfoModel(email: email, username: username)
                            complition(nil)
                        }
                    } else {
                        print("Invalid response format")
                        complition(String(data: data, encoding: .utf8)!)
                    }
                } catch {
                    print("Error parsing JSON data: \(error)")
                    complition(error.localizedDescription)
                }
            }
        }

        task.resume()
    }

    func addTask(coordinators: [String], description: String, name: String) {
        add2(coordinators: coordinators, description: description, name: name)
        return
        let urlString = "https://auth.hci.richardhere.dev/api/v1/add"
        let url = URL(string: urlString)

        struct Task: Codable {
            let coordinators: [String]
            let description: String
            let name: String
        }

        let task = Task(coordinators: coordinators, description: description, name: name)

        do {
            let encoder = JSONEncoder()
            let requestData = try encoder.encode(task)

            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData

            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                print("help")
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        print("success")
                    } else {
                        print("Unexpected status code: \(httpResponse.statusCode)")
                    }
                }
            }

            task.resume()
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }

    func add2(coordinators: [String], description: String, name: String) {
        Task {
            let urlString = "https://task.hci.richardhere.dev/task/v1/add"
            let url = URL(string: urlString)

            struct SendTaskModel: Codable {
                let coordinators: [String]
                let description: String
                let name: String
            }

            let task = SendTaskModel(coordinators: coordinators, description: description, name: name)

            do {
                let encoder = JSONEncoder()
                let requestData = try encoder.encode(task)

                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = requestData

                let (data, response) = try await URLSession.shared.data(for: request)
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let task = try JSONDecoder().decode(TaskModel.self, from: data)
                        DispatchQueue.main.async {
                            self.allTasks.append(task)
                        }
                        print("success")
                    } else {
                        print("Unexpected status code: \(httpResponse.statusCode)")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func approveTask(coordinator: String, taskId: String) {
        let urlString = "https://task.hci.richardhere.dev/task/v1/approve/\(coordinator)/\(taskId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("success")
                } else {
                    print("Unexpected status code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }

    func declineTask(coordinator: String, taskId: String) {
        let urlString = "https://task.hci.richardhere.dev/task/v1/decline/\(coordinator)/\(taskId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("success")
                } else {
                    print("Unexpected status code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }

    func deleteTask(with id: String) {
        let urlString = "https://task.hci.richardhere.dev/task/v1/delete/\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("Successfully deleted the task")
                } else {
                    print("Unexpected status code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }

    func getTasks() {
        let url = URL(string: "https://task.hci.richardhere.dev/task/v1/tasks")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let tasks = try decoder.decode(Tasks.self, from: data)

                DispatchQueue.main.async {
                    tasks.Tasks.forEach({self.allTasks.append($0)})
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }

    func getTasksForTest() -> [TaskModel] {
        let testTasks = [
            TaskModel(coordinators: ["Artyom", "Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Artyom", name: "Test 1", next: 1, status: 0, date: Date() - 1),
            TaskModel(coordinators: ["Artyom"], description: "Some description", id: UUID().uuidString, initiator: "Pavel", name: "Test 2", next: 2, status: 0, date:  Date() - 2),
            TaskModel(coordinators: ["Richard"], description: "Some description", id: UUID().uuidString, initiator: "Richard", name: "Test 3", next: 4, status: 1, date:  Date()),
            TaskModel(coordinators: ["Ilya"], description: "Some description", id: UUID().uuidString, initiator: "Pavel", name: "Test 4", next: 5, status: 1, date:  Date() - 5),
            TaskModel(coordinators: ["Ilya", "Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Ilya", name: "Test 5", next: 6, status: 2, date:  Date() - 1),
            TaskModel(coordinators: ["Pavel"], description: "Some description", id: UUID().uuidString, initiator: "Richard", name: "Test 6", next: -1, status: 2, date: Date())
        ]

        return testTasks
    }
}
