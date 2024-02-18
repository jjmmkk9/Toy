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
    @State private var vm = PopupViewModel.shared
    
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

                MainCustomTab(selected: $selected)
                    .padding(.bottom, -10)
            }
            .ignoresSafeArea(.keyboard)

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
                PlusButton(clicked: $clicked)
                    .zIndex(2.0)
                    .padding()
                    .offset(y: -60.0)
                    .opacity(vm.isOpen ? 0 : 1)
            }
            
            if vm.isOpen {
                Color.black.opacity(0.6)
                    .zIndex(3.0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            vm.isOpen = false
                        }
                    }
                    .ignoresSafeArea()
                
                WhitePopup{
                    switch vm.type {
                        
                    case "logout" : LogoutPopupView()
                        
                    case "folder": NewFolderPopupView()
                    
                    case "resign" : ResignPopupView()
                        
                    default: AnyView(EmptyView())
                    }

                }
                    .zIndex(4.0)
                    .padding(.horizontal, 40)
                    .offset(y: -80)
            }
            
            
            
        }
        .background(Color("tempColor"))
    }
}

#Preview {
    ContentView()
}
