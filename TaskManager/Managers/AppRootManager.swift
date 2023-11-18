//
//  AppRootManager.swift
//  TaskManager
//
//  Created by Artem Shuneyko on 12.11.23.
//

import Foundation

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: AppRoots = .entrance
    
    enum AppRoots {
        case entrance
        case main
    }
}
