//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Alec Morrison on 6/11/23.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
