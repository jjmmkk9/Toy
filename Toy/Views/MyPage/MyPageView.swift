//
//  MyPageView.swift
//  Toy
//
//  Created by 조문기 on 2/13/24.
//

import SwiftUI


class UserProfileViewModel: ObservableObject {
    
    static let `default` = UserProfileViewModel()
    
    @Published var name: String = "조문기"
    @Published var email: String = "jmk9635@naver.com"
    @Published var image : Image? = Image("cuham")
    
    func makeProfileHorizontal() -> some View{
        HStack{
            VStack(alignment: .leading){
                Text(self.name)
                Text(self.email)
                    .foregroundStyle(Color("blackWhite"))
            }
            Spacer()
            if let image = self.image{
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width:50, height: 50)
            }else{
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:50, height: 50)
            }
        }
    }
    
}

struct MyPageView: View {
    @StateObject var profile = UserProfileViewModel.default
    
    var body: some View {
        NavigationStack {
            ScrollView{
                profile.makeProfileHorizontal()
                
                RoundedRectangle(cornerRadius: 20.0)
                    .frame(height: 230)
                    .foregroundStyle(Color(UIColor.MyTheme.bgColor))
                    .overlay{
                        VStack(alignment: .leading, spacing: 20){
                            HStack(spacing: 20){
                                Image("progressRing")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 90)
                                VStack(alignment: .leading, spacing: 10){
                                    Text("남은 시간 226분 / 300분 >")
                                        .foregroundStyle(.black)
                                    Text("2024.02.09. 00:00 갱신 예정")
                                        .font(.callout)
                                        .foregroundStyle(.gray)
                                }
                            }
                            Divider()
                            Text("남은 시간이 모두 소진되면, 파일 업로드는 제한되지만 녹음은 무제한 변환 가능합니다.")
                                .foregroundStyle(.gray)
                                .font(.system(size: 14))
                        }
                        .padding(20)
                    }
                    .padding(.vertical, 30)
                
                VStack(alignment: .leading, spacing: 25){
                    Text("내 정보")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                    
                    NavigationLink {
                        ProfileInfoView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        MyPageRow(text: "프로필 정보")
                        
                    }
                    NavigationLink {
                        AccountInfoView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        MyPageRow(text: "계정 정보")
                        
                    }
                    
                    
                    
                    Text("이용 설정")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 14))
                    
                    NavigationLink {
                        LanguageSelectView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        MyPageRow(text: "인식 언어")
                    }
                    NavigationLink {
                        InterestingView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        MyPageRow(text: "관심 분야")
                    }
                    NavigationLink {
                        VStack(spacing: 100){
                            BackButtonWithHeader("알림")
                            Text("알림이 없습니다.")
                            Spacer()
                        }
                        .padding(20)
                        .navigationBarBackButtonHidden()
                    } label: {
                        MyPageRow(text: "알림")
                    }
                }
                
            }
            .padding(20)
        }
    }
}

struct BackButtonWithHeader : View {
    var header : String
    init(_ header: String) {
        self.header = header
    }
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            Image(systemName: "arrow.left")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    dismiss()
                }
            
            Text(header)
                .font(.title3)
        }
        .foregroundStyle(Color("blackWhite"))
        .frame(maxWidth: .infinity)
        
        
    }
}


private struct MyPageRow : View {
    var text : String
    var body: some View {
        HStack{
            Text(text)
                .foregroundStyle(Color("blackWhite"))
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    MyPageView()
}
