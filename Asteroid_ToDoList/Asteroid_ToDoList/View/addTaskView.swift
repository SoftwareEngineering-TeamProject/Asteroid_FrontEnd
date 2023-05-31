//
//  addTaskView.swift
//  Asteroid_ToDoList
//
//  Created by Phil on 2023/05/31.
//

import SwiftUI


struct addTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel :ListViewModel
    @State var TaskField:String = ""
    @State var alertContent:String=""
    @State var showAlert:Bool=false
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("추가 할 작업을 입력해주세요!",text:$TaskField)
                    .padding(.horizontal)
                    .frame(height:60)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.958, saturation: 0.0, brightness: 0.912)/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                Button(
                    action:
                        handleSaveClick
                    ,label:{
                    Text("등록하기")
                            .frame(height:60)
                            .frame(maxWidth:.infinity)
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(10)
                    })
               
                            
            }
            .padding(12)
        
           
        }
        .navigationTitle("작업 추가하기 ✏️")
        .alert(isPresented:$showAlert , content:setAlert)

    
    }
    func handleSaveClick(){
        if(listViewModel.textChek(text:TaskField )){
        listViewModel.addTask(title: TaskField)
            presentationMode.wrappedValue.dismiss()
            
        }else{
            alertContent="2글자 이상부터 등록 하실 수 있어요.. 🥲"
            showAlert.toggle()
        }
    }
    func setAlert()->Alert{
        return Alert(title:Text(alertContent))
    }
    
}

struct addTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            addTaskView()
        }
        .environmentObject(ListViewModel())

    }
}

