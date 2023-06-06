//
//  ContentView.swift
//  Asteroid_ToDoList
//
//  Created by Phil on 2023/05/31.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel :ListViewModel
    
    var body: some View {
        ZStack {
            if listViewModel.tasks.isEmpty{
                NoTasksView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            }else{
                List{
                    ForEach(listViewModel.tasks){task in
                        ListRowView(task: task)
                            .onTapGesture {
                                withAnimation(.easeInOut){
                                    listViewModel.updateTask(task: task)
                                }
                                
                                
                            }
                    }
                    .onDelete(perform: listViewModel.deleteTask)
                    .onMove(perform: listViewModel.moveTask )
                }.listStyle(PlainListStyle())
            }
        }
        
        .navigationTitle("할 일 목록 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("작업 추가",destination: addTaskView())
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            
            ListView()

        }
        .environmentObject(ListViewModel())
    }
}
