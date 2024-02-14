//
//  ProfileInfoView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI

struct ProfileInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "arrow.left")
                    .font(.title)
                
                Text("프로필 정보")
                    .font(.title3)
                Spacer()
            }
            .background(.yellow)
        }
        
        Button{
            //사진
            dismiss()
        }label: {
            ZStack{
                Image("cuham")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width:120)
                Circle()
                    .foregroundStyle(Color(UIColor.MyTheme.bgColor))
                    .frame(width: 35)
                    .overlay{
                        Image(systemName: "camera")
                            .foregroundStyle(.black)
                    }
                    .offset(x: 45, y: 35)
            }
            
        }
        
        TextField("text 입력",text: $text)
    }
}

#Preview {
    ProfileInfoView()
}
