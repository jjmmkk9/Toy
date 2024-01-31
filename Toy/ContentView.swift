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
                    ClovaMain()
                case .folder:
                    Text("folder")
                case .calender:
                    Text("calender")
                case .myPage:
                    Text("myPage")
                }
                
                Spacer()
                
                Divider()
                CustomTabView(selected: $selected)
                    .padding(.bottom, -10)
            }
            
            //2층
             if clicked{
                 Color.black.opacity(0.6)
                     .onTapGesture {
                         clicked.toggle()
                     }
             }
            if selected == .home || selected == .folder {
                //3층
                PlusButton(clicked: $clicked)
                    .padding()
                    .offset(y: -60.0)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
