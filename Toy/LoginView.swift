//
//  LoginView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import SwiftUI


struct LoginView: View {
    
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var isLoginSuccessful : Bool = false
    
    var body: some View {
        VStack {
            Image("umbagog")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            .padding(.bottom, 20)
        }
        
        Text("Apple Login")
        TextField("Username", text: $username)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal,20)
            .textInputAutocapitalization(.never)
        SecureField("Password", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textInputAutocapitalization(.never)
            .padding(.horizontal,20)
        
        Button("Login") {
                if username == "user" && password == "password" {
                    isLoginSuccessful = true
                    print("login")
                } else {
                    isLoginSuccessful = false
                    print("fail")
                }
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)

            if isLoginSuccessful {
                Text("Login Successful!")
                    .foregroundColor(.green)
                    .padding(.top, 20)
            } else {
                Text("Invalid username or password.")
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
    }
    
   
}

#Preview {
    LoginView()
}
