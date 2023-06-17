//
//  LoginView.swift
//  Oauth_alamofire_tutorial
//
//  Created by Jeff Jeong on 2021/10/30.
//

import Foundation
import SwiftUI
import Alamofire


struct LoginView : View {
    
    @State private var isPopoverVisible = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var navigateToMyListView = false
    
    var body: some View {
            VStack {
                Text("로그인 하세요!")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.green)
                Spacer().frame(height: 100)
                TextField("이메일을 입력하세요", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("패스워드를 입력하세요", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                            Button(action: loginUser) {
                                Text("Login")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }.alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Error"),
                                    message: Text("아이디 혹은 비밀번호가 잘못되었습니다."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }

               NavigationLink( destination: MyListsView(),isActive: $navigateToMyListView) {
                   EmptyView()
                   Text("LoginPass")
                       .padding()
                       .background(Color.green)
                       .foregroundColor(.white)
                       .cornerRadius(8)
                }
            }
            .padding()
    }
    

    

    func loginUser() {
        let url = "https://port-0-asteroid-backend-dihik2mlis5q700.sel4.cloudtype.app/auth/login"
        let parameters = [
            "email": email,
            "password": password
        ] as Dictionary
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { response in
            print(response)
            switch response.result {
            case .success(let id):
                if id is Int {
                    UserDefaults.standard.set(id, forKey: "userId")
                    navigateToMyListView = true
                }
            case .failure(let error):
                print(error)
                // Show an alert for failure
                showAlert = true
            }
        }
    }

}


