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
        Text(buttonTxt)
            .font(.caption)
            .bold()
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .foregroundStyle(buttonSelected ? .black : .gray)
        
            .background(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(buttonSelected ? .white : Color(red: 236/255, green: 236/255, blue: 236/255))
                    .overlay(
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .stroke(buttonSelected ? .black : .clear, lineWidth: 2)
                    )
            )
        
    }
}

#Preview {
    EclipseButton(buttonTxt: "최근", buttonSelected: .constant(false))
}
