//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject private var appRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .entrance:
                    EntranceView()
//                        .transition(.opacity)
//                        .animation(.easeInOut(duration: 0.3))
                    
                case .main:
                    MainView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
