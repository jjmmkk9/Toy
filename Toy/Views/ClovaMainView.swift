//
//  ClovaMain.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct ClovaMainView: View {
    @State private var recentButtonSelected = true
    @State private var sharedButtonSelected = false

    
    var body: some View {
            
            //1층
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
            
            ScrollView{
                    ScrollView(.horizontal, showsIndicators: false){
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
                    
                //최근, 공유받은
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
                //
                    if recentButtonSelected {
                        ForEach(0..<4){_ in
                            RecordItem(record: Record.default)
                                .padding(.horizontal, 20)
                        }
                        //없으면
                        
                    } else if sharedButtonSelected {
                        //공유받은 노트가 없으면
                        NoteNothingView(noteCategory: "공유 받은")
                        //있으면 뿌리기
                    }
                
                //페이지뷰!!
                PageView(pages: blogBigItems)
                
                VStack(alignment: .leading, spacing: 30){
                    Text("유용한 기능 알아보기")
                        .font(.headline)
                        .bold()
                    UsefulFeatures()
                }
                .padding(20)
                
                
                
            }
            .background(Color(red: 247/255, green: 247/255, blue: 247/255))


}
}

#Preview {
    ClovaMainView()
}
