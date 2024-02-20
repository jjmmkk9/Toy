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
    @State private var isPresented : Bool = false
    
    @StateObject var modelData = ModelData.modelData
    
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
            .foregroundColor(Color("blackWhite"))
            .padding( 20)
            .background(Color("tempColor"))
            
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
                
                
                VStack{
                    if recentButtonSelected {
                        if !modelData.records.isEmpty {
                            detailOpen(records: $modelData.records)
                        }else{
                            noteNothingInfo(noteName: "최근")
                        }

                    } else{
                        noteNothingInfo(noteName: "공유 받은")
                    }
                }
                .padding([.horizontal,.bottom] ,20)
                
                
                //페이지뷰!!
                PageView(pages: modelData.blogBigItems)
                
                VStack(alignment: .leading, spacing: 30){
                    Text("유용한 기능 알아보기")
                        .font(.headline)
                        .bold()
                    UsefulFeatures()
                }
                .padding(20)

            }
            .background(Color("bgColor"))


    }

}

extension View{
    func roundedField() -> some View{
        self
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundStyle(Color("whiteItemColor"))
            )
    }
    
    func detailOpen(records : Binding<[Record]>) -> some View{
        return ForEach(records.wrappedValue.indices, id:\.self){index in
            let recordBinding = records[index]
            RecordItem(record: recordBinding.wrappedValue)
                .onTapGesture {
                    recordBinding.isPresented.wrappedValue.toggle()
                }
                .fullScreenCover(isPresented: recordBinding.isPresented, content: {
                    RecordDetailView(record: recordBinding.wrappedValue)
                })
        }
    }
}
struct noteNothingInfo: View {
    var noteName: String
    var body: some View {
        VStack{
            Image(systemName: "link.circle.fill")
                .resizable()
                .foregroundStyle(.purple)
                .frame(width: 25, height: 25)
            Text("\(noteName) 노트가 없어요.")
                .font(.headline)
        }
        .roundedField()
    }
}

#Preview {
    ClovaMainView()
}
