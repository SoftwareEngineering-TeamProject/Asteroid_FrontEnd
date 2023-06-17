//
//  ContentView.swift
//  LogIn
//
//  Created by 황인성 on 2023/06/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Spacer().frame(height: 100)
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 160))
                Spacer()
                NavigationLink(destination: LoginView(), label: {
                    HStack{
                        Spacer()
                        Text("로그인 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }).padding([.bottom], 10)
                
                Spacer().frame(height: 20)
                
                NavigationLink(destination: RegisterView(), label: {
                    HStack{
                        Spacer()
                        Text("회원가입 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                
                Spacer()
                Spacer()
            }//VStack
            .padding()
        }// NavigationView
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
