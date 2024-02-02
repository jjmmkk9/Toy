//
//  SwiftUIView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI
//backGroundColor (Color(red: 247/255, green: 247/255, blue: 247/255)) 
struct BlogBigItem: View {
    var text : String
    var btnColor: Color
    var image : String
    var isWhite: Bool
    
    var body: some View {
        
        
        HStack{
            VStack (alignment: .leading, spacing: 8){
                Text(text)
                .font(.title2)
                .bold()
                .foregroundStyle(isWhite ? .white : .black)
                .fixedSize(horizontal: true, vertical: true)
                Text("자세히 보기")
                    .foregroundStyle(isWhite ? Color(red: 211 / 255, green: 204 / 255, blue: 204 / 255) : .gray)
            }
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                
        }
        .padding(50)
        
        .background(
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .foregroundStyle(btnColor)
            .padding(20)
            .background(Color(red: 247/255, green: 247/255, blue: 247/255))
        )
        .frame(height: 160)
        
            
    }
}

#Preview {
    BlogBigItem(text: "클로바 노트,\n이럴때 유용해요!", btnColor: Color(red: 219 / 255, green: 208 / 255, blue: 123 / 255), image: "root", isWhite: false)
}
