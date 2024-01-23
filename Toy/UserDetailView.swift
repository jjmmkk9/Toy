//
//  UserDetailView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import SwiftUI

struct UserDetailView: View {
    var user : User
    var body: some View {
        
        VStack(alignment:.leading, spacing: 10) {
            Text("Hello, \(user.username)!")
                .font(.title)
            Text("username : \(user.username)")
            Text("email : \(user.email)")
        }
        
    }
}

#Preview {
    UserDetailView(user: users[0])
}
