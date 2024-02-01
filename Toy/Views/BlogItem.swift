//
//  MyButton.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct BlogItem: View {
    var text : String
    var textColor: Color?
    var color: Color
    var imgName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 150, height: 150)
            .foregroundStyle(color)
        
            .overlay(
                
                VStack {
                    Text(text)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(textColor ?? .white)
                        .fixedSize(horizontal: true, vertical: true)
                        .padding()
                    
                    Image(imgName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
<<<<<<< HEAD:Toy/BlogItem.swift
                
=======
            
>>>>>>> faf9be87a0dff88480154e4af8a8df5c96da074e:Toy/Views/BlogItem.swift
            )
        
    }
}

#Preview {
    BlogItem(
        text: "모바일, PC \n어디서든 편하게", color: Color(red: 24/255, green: 136/255, blue: 97/255), imgName: "mic")
}
