//
//  ListViewModel.swift
//  Asteroid_ToDoList
//
//  Created by Phil on 2023/05/31.
//


import Foundation

class ListViewModel: ObservableObject {
   
    @Published var tasks:[taskModel] = [] {
        didSet{
            saveTasks()
        }
    }
    var tasksKey:String="tasks_list"
    
    init(){
        getTasks()
    }
    
    func getTasks(){

        guard
            let data=UserDefaults.standard.data(forKey:tasksKey),
            let decoded  = try? JSONDecoder().decode([taskModel].self,from:data)
        else {return}
        self.tasks=decoded
     
    
    }
    //delete the task from the list
    func deleteTask(indexSet: IndexSet){
        tasks.remove(atOffsets: indexSet)
    }
    //move the task in the list
    func moveTask(from: IndexSet,to: Int){
        tasks.move(fromOffsets: from, toOffset: to)
    }
    func addTask(title:String){
        let newTask = taskModel(title:title,isCompleted: false)
        tasks.append(newTask)
    }
    //check text is empty before add
    func textChek(text:String)->Bool{
        text.count < 2 ? false:true
    }
    //update task completion
    func updateTask(task:taskModel){
        if let index=tasks.firstIndex(where: { $0.id==task.id }){
            tasks[index]=task.updateTaskCompletion()
        }
    }
    //save tasks
    func saveTasks(){
        if let endcoded = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(endcoded,forKey: tasksKey)
        }
    }
    
}
