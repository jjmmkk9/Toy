//
//  NewFolderPopup.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI
enum Popup {
    case logout, folder, resign
    
    case removeOrTransfer
}

class WhitePopupViewModel : ObservableObject{
    static let shared = WhitePopupViewModel()
    
    private init() {
        self.isOpen = isOpen
        self.type = type
    }
    
    @Published var isOpen : Bool = false{
        didSet{
            print("white popup open: \(isOpen)")
        }
    }
    @Published var type: Popup?
    
}

class BottomPopupViewModel : ObservableObject{
    static let shared = BottomPopupViewModel()
    
    @Published var isOpen : Bool = false{
        didSet{
            print("bottom popup open: \(isOpen)")
        }
    }
    @Published var type: Popup?
    
}
struct WhitePopup<Content: View>: View {
    
    var page : Content
    init(@ViewBuilder content:() -> Content) {
        self.page = content()
    }
    
    var body: some View {
        page
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.white)
            )
            .padding(.horizontal, 40)
            .position(x:UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3)
    }
}
struct NewFolderPopupView:View {
    enum Field : Hashable{
        case name
    }
    var vm : WhitePopupViewModel = WhitePopupViewModel.shared
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
    var vm : WhitePopupViewModel = WhitePopupViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            Text("로그아웃")
                .bold()
                .font(.title2)
                .foregroundStyle(.black)
            
            Text("로그아웃 하시겠어요?")
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
    var vm : WhitePopupViewModel = WhitePopupViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            Text("탈퇴")
                .bold()
                .font(.title2)
                .foregroundStyle(.black)
            
            Text("탈퇴 하시겠어요?")
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

struct BottomPopup<Content: View>: View {
    var page : Content
    @StateObject var popupVm = BottomPopupViewModel.shared
    
    init(@ViewBuilder content:() -> Content) {
        self.page = content()
    }
    
    var body: some View {
            // 팝업 뷰
            VStack {
                Spacer()
                page
            }
            .offset(y: popupVm.isOpen ? 0 : UIScreen.main.bounds.height)
            .ignoresSafeArea()

    }
}

struct RemoveOrTransferPopupView:View {
    @StateObject var popupVm = BottomPopupViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Button(action: {
                popupVm.isOpen.toggle()
            }) {
                Image(systemName: "trash")
                Text("삭제")
                    
            }
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                popupVm.isOpen.toggle()
            }) {
                Image(systemName: "folder")
                Text("이동")
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
        .bottomPopup()
    }
}

extension View{
    func bottomPopup() -> some View{
        self
            .padding(.bottom, 20)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
    }
}
#Preview {
    //    WhitePopup{
    //        LogoutPopupView()
    //    }
    BottomPopup{
        RemoveOrTransferPopupView()
    }
}
