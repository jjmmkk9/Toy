//
//  RecordDetailView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/2/24.
//

import SwiftUI
import WrappingHStack

struct RecordDetailView: View {
    var record : Record = Record.default
    
    var body: some View {
        //header
        HStack(spacing: 15){
            Button{
                
            }label: {
                Image(systemName: "xmark")
            }
            
            Spacer()
            
            Button{
                
            }label: {
                Image(systemName: "highlighter")
            }
            Button{
                
            }label: {
                Image(systemName: "magnifyingglass")
            }
            Button{
                
            }label: {
                Image(systemName: "circle.tophalf.filled")
            }
            Button{
                
            }label: {
                Image(systemName: "arrowshape.turn.up.right")
            }
            Button{
                
            }label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90.0))
            }
        }
        .font(.title2)
        .padding(.leading, 20)
        
        //content
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                Text("1.29 월 10:26(16:46 수정) . 73분 44초")
                Text(record.name)
                    .font(.title)
                
                Button{
                    //창띄우기
                }label: {
                    Text("주요키워드")
                    Image(systemName: "info.circle")
                }
                .foregroundStyle(.black)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            
            WrappingHStack(alignment: .leading){
                ForEach(record.keyWord, id: \.self){keyword in
                    KeywordBtn(keyword: keyword)
                }
            }
            .padding(20)

            
        }
        
        
    }
    
    
}

struct KeywordBtn: View {
    var keyword : String
    var body: some View {
        Text(keyword)
            .font(.caption)
            .padding(8)
            .background(Color(red: 243 / 255, green: 249 / 255, blue: 254 / 255))
            .foregroundStyle(.blue)
            .clipShape(Capsule())
    }
}




#Preview {
    RecordDetailView()
}
