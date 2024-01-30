//
//  ClovaMain.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct ClovaMain: View {
    @State private var recentButtonSelected = true
    @State private var sharedButtonSelected = false
    
    var body: some View {
            HStack{
                Text("CLOVA")
                    .bold()
                    .font(.title2)
                Text("Note")
                    .font(.title2)
                
                Spacer()
                
                Button{
                    //code
                }label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23))
                }.padding(.trailing, 10)
                Button{
                    print("Button tapped!")
                }label: {
                    Image(systemName: "bell")
                        .font(.system(size: 23))
                    
                }
            }
            .foregroundColor(.black)
            .padding( 20)
        
        //정렬을 사용하여 이미지가 Scrollview가 사용가능한 모든 공간을 사용하도록 한다. 왠지 모르겠는데 이렇게 하면 내가 공중부양 시키고 싶은 버튼이 그쪽으로 가서 붙음
        ZStack(alignment: .bottomTrailing) {
            ScrollView{
                    ScrollView(.horizontal){
                        HStack{
                            Link(destination: URL(string: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184899363&proxyReferer=")!, label: {
                                BlogItem(
                                    text: "모바일, PC \n어디서든 편하게", color: Color(red: 24/255, green: 136/255, blue: 97/255), imgName: "mic")
                            })
                            Link(destination: URL(string: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184899363&proxyReferer=")!, label: {
                                BlogItem(
                                    text: "AI 기능으로\n요점만 쏙쏙", textColor: .black, color: Color(red: 196/255, green: 223/255, blue: 203/255), imgName: "apple")
                            })
                            
                            Link(destination: URL(string: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184899363&proxyReferer=")!, label: {
                                BlogItem(
                                    text: "중요한 정보만\n모아서 한눈에", color: Color(red: 185/255, green: 85/255, blue: 143/255), imgName: "moa")
                            })
                            
                            
                        }.padding(.horizontal, 20)
                        }
                    
                    HStack{
                        Button {
                            if !recentButtonSelected{
                                recentButtonSelected = true
                                sharedButtonSelected = false
                            }
                        }label: {
                            EclipseButton(buttonTxt: "최근", buttonSelected: $recentButtonSelected)
                        }
                        
                        Button {
                            if !sharedButtonSelected{
                                sharedButtonSelected = true
                                recentButtonSelected = false
                            }
                        }label: {
                            EclipseButton(buttonTxt: "공유 받은", buttonSelected: $sharedButtonSelected)
                        }
                        Spacer()
                    }
                    .padding(20)

                    if recentButtonSelected {
                        ForEach(0..<4){_ in
                            RecordItem(record: Record.default)
                                .padding(.horizontal, 20)
                        }
                    } else if sharedButtonSelected {
                        Text("Display Shared Files View")
                    }
//
                    
            }
            .background(Color(red: 247/255, green: 247/255, blue: 247/255))
            
            CircleButton()
                .padding()
                .shadow(radius: 5)
                .offset(x: 10.0, y:10.0)
        }
            
}
}

#Preview {
    ClovaMain()
}
