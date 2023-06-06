//
//  Asteroid_ToDoListApp.swift
//  Asteroid_ToDoList
//
//  Created by Phil on 2023/05/31.
//

import SwiftUI

@main
struct TodoListApp: App {
    @StateObject var listViewModel:ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()

            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(listViewModel)
        }
    }
}
