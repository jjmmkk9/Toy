//
//  MyCalendarIcon.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/15/24.
//

import SwiftUI

struct CalendarIconSelected: View {
    var body: some View {
        VStack(spacing: 2){
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 28, height: 4)
            
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 28, height: 22)
                .overlay{
                    Text(String(getDay()))
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color("tempColor"))
                }
        }
        .foregroundStyle(Color("blackWhite"))
    }

}

struct CalendarIcon:View {
    var body: some View {
        VStack(spacing: 0){
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
                .frame(width: 28, height: 5)
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
                .frame(width: 28, height: 22)
                .overlay{
                    Text(String(getDay()))
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color("blackWhite"))
                }
        }
        .foregroundStyle(Color("blackWhite"))
    }
}

#Preview {
    Group{
        CalendarIconSelected()
        Divider()
        CalendarIcon()
    }
}
