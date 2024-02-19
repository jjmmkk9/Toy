//
//  CustomTabView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

enum Tab{
    case home
    case folder
    case calender
    case myPage
}


struct MainCustomTab: View {
    @Binding var selected : Tab
    var body: some View {
        
        VStack(spacing: 0){
            Rectangle()
                .frame(height: 2)
                .foregroundStyle(.gray) /// TODO: - .placeholder로 바꾸기 
            HStack (alignment: .bottom, spacing: UIScreen.main.bounds.width/4 - 40){
                Button{
                    selected = .home
                }label: {
                    Image(systemName: selected == .home ? "house.fill" : "house")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color("blackWhite"))
                        .animation(nil, value: selected)
                }
                
                
                Button{
                    selected = .folder
                }label: {
                    Image(systemName: selected == .folder ? "folder.fill" : "folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color("blackWhite"))
                        .animation(nil, value: selected)
                }
                Button{
                    selected = .calender
                }label: {
                    if selected == .calender{
                        CalendarIconSelected()
                            .animation(nil, value: selected)
                        
                    }else{
                        CalendarIcon()
                            .animation(nil, value: selected)
                    }
                }
                
                Button{
                    selected = .myPage
                    
                }label: {
                    Image(systemName: selected == .myPage ? "person.fill" : "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundStyle(Color("blackWhite"))
                        .animation(nil, value: selected)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 70)
            .background(Color("tempColor"))
        }
        

    }
}

#Preview {
    MainCustomTab(selected: .constant(.myPage))
}
