//
//  taskModel.swift
//  Asteroid_ToDoList
//
//  Created by Phil on 2023/05/31.
//


import Foundation

struct taskModel: Identifiable ,Codable{
    var id:String = UUID().uuidString
    let title:String
    let isCompleted:Bool
    
    // update the task {setter java be like  }
    func updateTaskCompletion()-> taskModel{
        return taskModel(title:title,isCompleted: !isCompleted)
    }
}
