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
            }
        }
        .padding()
    }
    
    func registerUser() {
        let parameters: [String: Any] = [
            "username": email,
            "password": password
        ]
        
        AF.request("https://port-0-asteroid-backend-dihik2mlis5q700.sel4.cloudtype.app/register",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: RegisterResponse.self) { response in
                switch response.result {
                case .success(_):
//                    print("Registration successful! Message: \(registerResponse.userId)")
                    print("회원가입 성공")
                    // Handle other properties from the response as needed
                case .failure(_):
//                    print("Registration failed: \(error)")
                    print("회원가입 실패")
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
