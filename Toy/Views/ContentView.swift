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
    
    @StateObject private var popupVm = PopupViewModel.shared
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            VStack(spacing:0){
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
                    .opacity(popupVm.isOpen ? 0 : 1)
            }
            
            if popupVm.isOpen {
                Color.black.opacity(0.6)
                    .zIndex(3.0)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)){
                            popupVm.isOpen = false
                        }
                    }
                    .ignoresSafeArea(.all)
                
                WhitePopup{
                    switch popupVm.type {
                        
                    case "logout" : LogoutPopupView()
                        
                    case "folder": NewFolderPopupView()
                    
                    case "resign" : ResignPopupView()
                        
                    default: EmptyView()
                    }

                }
                    .zIndex(4.0)
                    .ignoresSafeArea(.keyboard)
            }
            
            
            
        }
        .background(Color("tempColor"))
    }
}

#Preview {
    ContentView()
}
