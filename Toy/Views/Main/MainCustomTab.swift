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
        
        HStack (alignment: .bottom, spacing: UIScreen.main.bounds.width/4 - 40){
            Button{
                selected = .home
            }label: {
                Image(selected == .home ? "home_select" : "home_unselect")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            
            Button{
                selected = .folder
            }label: {
                Image(selected == .folder ? "file_select" : "file_unselect")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            Button{
                selected = .calender
            }label: {
                Image(selected == .calender ? "calender_select" : "calender_unselect")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            Button{
                selected = .myPage
            }label: {
                Image(selected == .myPage ? "myPage_select" : "myPage_unselect")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 70)
        
    
    }
}

#Preview {
    MainCustomTab(selected: .constant(.home))
}
