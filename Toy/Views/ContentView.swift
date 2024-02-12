//
//  ContentView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var clicked : Bool = false
    @State private var wheelOn : Bool = false
    @State private var selected : Tab = .home
    
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            VStack{
                switch selected {
                case .home:
                    ClovaMainView()
                case .folder:
                    FolderView()
                case .calender:
                    CalenderView(clicked: $clicked, wheelOn: $wheelOn)
                case .myPage:
                    MyPageView()
                }
                
                Spacer()
                
                Divider()
                MainCustomTab(selected: $selected)
                    .padding(.bottom, -10)
            }
            
            //2층
            if clicked{
                Color.black.opacity(0.6)
                    .zIndex(1.0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            clicked = false
                        }
                    }
                    .ignoresSafeArea()
                
                if wheelOn {
                    DatePickerView(clicked: $clicked, wheelOn: $wheelOn)
                        .zIndex(2.0)
                }
            }
            if selected == .home || selected == .folder {
                //3층
                //이 버튼 클릭할때만
                PlusButton(clicked: $clicked)
                    .zIndex(2.0)
                    .padding()
                    .offset(y: -60.0)
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
