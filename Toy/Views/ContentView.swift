//
//  ContentView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var clicked : Bool = false
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
                    CalenderView(month: Date())
                case .myPage:
                    Text("myPage")
                }
                
                Spacer()
                
                Divider()
                MainCustomTab(selected: $selected)
                    .padding(.bottom, -10)
            }
            
            
            //2층
            if clicked{
                Color.black.opacity(0.6)
                    .zIndex(1.0) //zindex를 안줘서 사라질때 zindex가 ClovaMain의 Scrollview보다 아래로 내려가면서 스크롤뷰 부분만 먼저 사라지는것처럼 보였다. 버그 해결!
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            clicked.toggle()
                        }
                    }
                    .ignoresSafeArea()// safeArea에만 까만색 안깔리는거 해결
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
