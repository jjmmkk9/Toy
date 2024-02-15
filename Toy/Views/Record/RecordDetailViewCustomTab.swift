//
//  TabTest.swift
//  Toy
//
//  Created by 조문기 on 2/4/24.
//

import SwiftUI

enum detailTab: String, CaseIterable {
    case voiceRecord = "음성 녹음"
    case memoSummary = "메모 요약"
}

struct RecordDetailViewCustomTab: View {
    @State private var selectedTab: detailTab = .voiceRecord
    var record : Record
//    @Namespace private var animation
    
    var body: some View {
        VStack {
            animate()
            testView(record: record, tests: selectedTab)
                }
            }
            @ViewBuilder
            private func animate() -> some View {
                HStack {
                    ForEach(detailTab.allCases, id: \.self) { item in
                        VStack {
                            Text(item.rawValue)
                                .font(.title3)
                                .frame(maxWidth: .infinity/4, minHeight: 50)
                                .foregroundColor(selectedTab == item ? Color("blackWhite") : .gray)

                            if selectedTab == item {
                                Capsule()
                                    .foregroundColor(Color("blackWhite"))
                                    .frame(height: 3)
//                                    .matchedGeometryEffect(id: item, in: animation)
                            }
                            
                        }
                        .onTapGesture {
                            self.selectedTab = item
                        }
                    }
                }
            }
        }

        struct testView : View {
            var record : Record
            var tests : detailTab
            var body: some View {
                ScrollView(.vertical, showsIndicators: false) {
                    switch tests {
                    case .voiceRecord :
                        ScrollView{
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1.0)
                                .foregroundStyle(.secondary)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .overlay(
                                    Text("AI가 요약한 핵심 내용 확인하기")
                                        .foregroundStyle(Color("blackWhite"))
                                )
                            
                        }
                        let people = record.people
                        
                        ForEach(record.allText, id: \.self){string in
                            
                            textRow(number: Int.random(in: 1...people), text: string)
                        }
                        
                    case .memoSummary:
                        Text("사이즈 참고해주세요")
            
                    }
                }
            }

        }

struct textRow : View {
    var number: Int
    var text : String
    let colors : [Color] = [.red, .cyan, .purple, .orange, .blue]
    
    var body: some View {
        HStack(alignment:.top, spacing: 15){
            Text("\(number)")
                .foregroundStyle(.white)
                .font(.headline)
                .frame(width: 30, height: 30)
                .background(
                    Circle().fill(colors[number - 1])
                )
            
            VStack(alignment: .leading){
                HStack{
                    Text("참석자 \(number)")
                        .font(.headline)
                        .bold()
                    Text("00:00")
                        .foregroundStyle(.gray)
                }
                Text(text)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        
        
    }
}

#Preview {
    RecordDetailViewCustomTab(record: ModelData.modelData.records[0])
}
