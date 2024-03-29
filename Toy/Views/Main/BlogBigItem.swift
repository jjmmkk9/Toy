//
//  SwiftUIView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI

struct BlogBigItem: View {
    var text : String
    var btnColor: Color
    var image : String
    var isWhite: Bool
    var destination: String
    
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
            .onTapGesture {
                if let url = URL(string: destination){
                    UIApplication.shared.open(url, options: [:])
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(btnColor)
                .frame(height: 150)
                .padding(20)
                .background(Color("bgColor"))
            )
            
    }
}


#Preview {
    BlogBigItem(text: "클로바 노트,\n이럴때 유용해요!", btnColor: Color(red: 219 / 255, green: 208 / 255, blue: 123 / 255), image: "root", isWhite: false, destination: "https://www.apple.com")
}
