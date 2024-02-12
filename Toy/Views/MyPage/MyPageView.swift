//
//  MyPageView.swift
//  Toy
//
//  Created by 조문기 on 2/13/24.
//

import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                HStack{
                    VStack(alignment: .leading){
                        Text("조문기")
                        Text("jmk9635@naver.com")
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Image("cuham")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width:50)
                    
                }

                
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
                                    Text("2024.02.09. 00:00 갱신 예정")
                                        .font(.callout)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            Divider()
                            Text("남은 시간이 모두 소진되면, 파일 업로드는 제한되지만 녹음은 무제한 변환 가능합니다.")
                                .foregroundStyle(.secondary)
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
                        Text("hi")
                    } label: {
                        HStack{
                            Text("프로필 정보")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("계정 정보")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("이용 현황")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
            
                    
                    
                    Text("이용 설정")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 14))
                    
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("자주 쓰는 단어")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("인식 언어")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("관심 분야")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                    NavigationLink {
                        Text("hi")
                    } label: {
                        HStack{
                            Text("알림")
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
            }
            .padding(20)
        }
    }
}

#Preview {
    MyPageView()
}
