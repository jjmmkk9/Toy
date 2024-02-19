//
//  NewFolderPopup.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI

class PopupViewModel : ObservableObject{
    static let shared = PopupViewModel()
    
    private init() {
        self.isOpen = isOpen
        self.type = type
    }
    @Published var isOpen : Bool = false{
        didSet{
            print(isOpen)
        }
    }
    @Published var type: String?
    
}

struct WhitePopup<Content: View>: View {
    
    var page : Content
    init(@ViewBuilder content:() -> Content) {
        self.page = content()
    }
    
    var body: some View {
        page
            .padding( 40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
            )

    }
}
struct NewFolderPopupView:View {
    enum Field : Hashable{
        case name
    }
    var vm : PopupViewModel = PopupViewModel.shared
    @State private var modelData = ModelData.modelData
    @State private var name : String = ""
    @FocusState var isFocused : Field?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("새 폴더 만들기")
                .foregroundStyle(.black)
                .font(.title3)
                .bold()
            
            ZStack(alignment: .leading){
                if name.isEmpty{
                    Text("폴더 이름")
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 2)
                        .transition(.opacity)
                }
                TextField("", text: $name)
                    .focused($isFocused, equals: .name)
                    .foregroundStyle(.black)
            }
            .onAppear(perform: {
                            isFocused = .name
                            
                        })
            Capsule()
                .frame(height: 2)
                .foregroundStyle(.gray)
                .padding(.bottom, 20)
            
            HStack(spacing: 30){
                Spacer()
                Button{
                    vm.isOpen = false
                }label: {
                    Text("취소")
                        .foregroundStyle(.black)
                }
                Button{
                    modelData.myFolders.append(name)
                    vm.isOpen = false
                }label: {
                    Text("만들기")
                        .foregroundStyle(name.isEmpty ? .gray : .blue)
                        .bold()
                }
                .disabled(name.isEmpty)
                
            }
        }
    }
}

struct LogoutPopupView :View {
    var vm : PopupViewModel = PopupViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("로그아웃")
                .bold()
                .font(.title2)
                .foregroundStyle(.black)
            
            Text("로그아웃 하시겠어요? 아마 안될텐데")
                .foregroundStyle(.black)
            
            HStack(spacing: 30){
                Spacer()
                Button{
                    vm.isOpen = false
                }label: {
                    Text("취소")
                        .foregroundStyle(.black)
                }
                Button{
                    
                    vm.isOpen = false
                }label: {
                    Text("확인")
                        .foregroundStyle(.blue)
                        .bold()
                }
                
            }
        }
    }
}
struct ResignPopupView :View {
    var vm : PopupViewModel = PopupViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("탈퇴")
                .bold()
                .font(.title2)
                .foregroundStyle(.black)
            
            Text("탈퇴 하시겠어요? 아마 안될텐데")
                .foregroundStyle(.black)
            
            HStack(spacing: 30){
                Spacer()
                Button{
                    vm.isOpen = false
                }label: {
                    Text("취소")
                        .foregroundStyle(.black)
                }
                Button{
                    
                    vm.isOpen = false
                }label: {
                    Text("확인")
                        .foregroundStyle(.blue)
                        .bold()
                }
                
            }
        }
    }
}

#Preview {
    WhitePopup{
        LogoutPopupView()
    }
}
