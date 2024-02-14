//
//  NewFolderPopup.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI

@Observable
class PopupViewModel{
    static let shared = PopupViewModel()
    var isOpen : Bool = false
    
    
}

struct NewFolderPopup: View {
    enum Field : Hashable{
        case name
    }
    @State private var vm = PopupViewModel.shared
    @State private var modelData = ModelData.modelData
    @State private var name : String = ""
    @FocusState var isFocused : Field?
    
    var body: some View {
            VStack(alignment: .leading, spacing: 20){
                Text("새 폴더 만들기")
                    .font(.title3)
                    .bold()
                
                TextField("폴더 이름", text: $name)
                    .autocorrectionDisabled()
                    .focused($isFocused, equals: .name)
                Capsule()
                    .frame(height: 2)
                    .foregroundStyle(.placeholder)
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
                            .bold()
                    }
                    .disabled(name.isEmpty)
                }
            }
            .padding(.horizontal, 40)
        
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 200)
                    .foregroundStyle(.white)
                    
            )
            .onAppear(perform: {
                            isFocused = .name
                            
                        })

    }
}

#Preview {
    NewFolderPopup()
}
