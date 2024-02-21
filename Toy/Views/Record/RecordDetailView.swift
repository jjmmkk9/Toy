//
//  RecordDetailView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/2/24.
//

import SwiftUI
import WrappingHStack



struct RecordDetailView: View {
    var record : Record
    @State private var selectedTab: Tab = .voiceRecord
    @Environment(\.dismiss) var dismiss
    
    
    enum Tab: Hashable {
            case voiceRecord
            case memoSummary
        }
    
    var body: some View {
        
        //header
        HStack(spacing: 15){
            Button{
                dismiss()
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
        .padding(20)
        .padding(.trailing, -10)
        .foregroundStyle(Color("blackWhite"))
        
        //content
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                Text("\(record.detailTimeString) . \(record.totalTimeString)")
                Text("\(record.name) \(record.id)")
                    .font(.title)
                    .bold()
                
                Button{
                    //창띄우기
                }label: {
                    Text("주요키워드")
                    Image(systemName: "info.circle")
                }
                .foregroundStyle(Color("blackWhite"))
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            
            //키워드
            WrappingHStack(alignment: .leading){
                ForEach(record.keyword, id: \.self){keyword in
                    KeywordBtn(keyword: keyword)
                }
            }
            .padding(20)

            RecordDetailViewCustomTab(record: record)
            
            
        }
        
        
    }
    
    
}

struct KeywordBtn: View {
    var keyword : String
    var body: some View {
        Text(keyword)
            .font(.caption)
            .padding(8)
            .background(Color("skyBlue"))
            .foregroundStyle(Color("blueWhite"))
            .clipShape(Capsule())
    }
}




#Preview {
    let modelData = ModelData.modelData
    return RecordDetailView(record: modelData.records[0])
}
