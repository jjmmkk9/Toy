//
//  AccountInfoView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI

struct AccountInfoView: View {
    var vm = PopupViewModel.shared
    var body: some View {
        VStack(spacing: 40){
            BackButtonWithHeader("계정 정보")
            
            VStack(alignment: .leading, spacing: 10){
                Text("이메일")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
                Text("jmk9635@naver.com")
                    
                
                Text("로그인 정보")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
                HStack{
                    Rectangle()
                        .foregroundStyle(.green)
                        .overlay(
                            Text("N")
                                .bold()
                                .foregroundStyle(.white)
                        )
                        .frame(width: 20, height: 20)
                    Text("NAVER")
                        .bold()
                    
                }
            
            }
            
            Divider()
                .overlay(.gray)
            
            Text("로그아웃")
                .onTapGesture {
                    vm.type = "logout"
                    vm.isOpen.toggle()
                }
            
            Spacer()
            
            Text("탈퇴하기")
                .foregroundStyle(.gray)
                .onTapGesture {
                    vm.type = "resign"
                    vm.isOpen.toggle()
                }
        }
        .padding([.horizontal, .top], 20)
    }
}

#Preview {
    AccountInfoView()
}
