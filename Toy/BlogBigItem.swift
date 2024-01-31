//
//  SwiftUIView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI

struct BlogBigItem: View {
    var body: some View {
        
        HStack{
            VStack (alignment: .leading, spacing: 8){
                Text("클로바 노트,\n이럴때 유용해요!")
                .font(.title2)
                .bold()
                .fixedSize(horizontal: true, vertical: true)
                Text("자세히 보기")
                .foregroundStyle(.brown)
            }
            Spacer()
            Image("root")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                
        }
        .padding(60)
        .frame(height: 160)
        .background(
            RoundedRectangle(cornerRadius: 25.0 )
            .foregroundStyle(Color(red: 219 / 255, green: 208 / 255, blue: 123 / 255)
                            )
            .padding(20)
        )
        
            
    }
}

#Preview {
    BlogBigItem()
}
