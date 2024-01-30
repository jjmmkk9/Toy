//
//  CircleButton.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct CircleButton: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/){
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 55, height: 55) // 버튼 크기 조절
                .foregroundColor(.black) // 버튼 색상
        }
        .padding()
    }
}

#Preview {
    CircleButton()
}
