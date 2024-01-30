//
//  CircleButton.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct EclipseButton:View{
    var buttonTxt : String
    
    @Binding var buttonSelected : Bool
    
    var body: some View{
        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            .foregroundStyle(buttonSelected ? .clear : Color(red: 236/255, green: 236/255, blue: 236/255))
            .overlay(
                Text(buttonTxt)
                    .font(.caption)
                    .bold()
                    .foregroundStyle(buttonSelected ? .black : .gray)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25.0)
                    .stroke(buttonSelected ? Color.black : Color.clear, lineWidth: 2)
                    )
    }
}
