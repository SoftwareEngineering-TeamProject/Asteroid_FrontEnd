//
//  LoginView.swift
//  Oauth_alamofire_tutorial
//
//  Created by Jeff Jeong on 2021/10/30.
//

import Foundation
import SwiftUI
import Alamofire

struct LoginResponse: Codable {
    let userId: Int
    // Add other properties based on your response structure
}

struct LoginView : View {
    
    @State private var isPopoverVisible = false
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                
                //            Button(action: registerUser) {
                //                Text("Register")
                //                    .padding()
                //                    .background(Color.blue)
                //                    .foregroundColor(.white)
                //                    .cornerRadius(8)
                //            }
                            Button(action: loginUser) {
                                Text("Login")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
               NavigationLink( destination: MyListsView()) {
                    Text("Loginpass")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
    }
    

    
    func loginUser() {
        let parameters: [String: Any] = [
            "username": email,
            "password": password
        ]
        
        AF.request("https://port-0-asteroid-backend-dihik2mlis5q700.sel4.cloudtype.app/login",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
//                    print("Login successful! Token: \(loginResponse.userId)")
                    print("로그인 성공")
                    UserDefaults.standard.set(loginResponse.userId, forKey: "userId")
                    // Handle other properties from the response as needed
                case .failure(_):
//                    print("Login failed: \(error)")
                    print("로그인 실패")
                }
            }
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif
