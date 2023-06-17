//
//  RegisterView.swift
//  Oauth_alamofire_tutorial
//
//  Created by Jeff Jeong on 2021/10/30.
//

import Foundation
import SwiftUI
import Alamofire


struct RegisterResponse: Codable {
    let userId: Int
    // Add other properties based on your response structure
}

struct RegisterView : View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var navigateToLoginView = false
    
    var body: some View {
        VStack {
            Text("회원가입 하세요!")
                .font(.title)
                .fontWeight(.regular)
                .foregroundColor(.blue)
            Spacer().frame(height: 100)
            TextField("이메일을 입력하세요", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("패스워드를 입력하세요", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: registerUser) {
                Text("Register")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("아이디 혹은 비밀번호가 잘못되었습니다."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            NavigationLink( destination: LoginView(),isActive: $navigateToLoginView) {
                EmptyView()
            }
        }
        .padding()
    }
    
    func registerUser() {

        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request("https://port-0-asteroid-backend-dihik2mlis5q700.sel4.cloudtype.app/auth/join",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate()
            .responseJSON{ response in
                switch response.result {
                case .success(let response):
                    print("Registration successful! Message: \(response)")
                    navigateToLoginView = true
                case .failure(let error):
                    print("Registration failed: \(error)")
                    showAlert = true
                }
            }
    }

}

#if DEBUG
struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
#endif
