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
    var record: Record
    //    @Namespace private var animation
    
    var body: some View {
        VStack {
            makeTabHeader()
            TabContentView(record: record ,tests: selectedTab)
            
        }
    }
    //MARK: - 탭 헤더
    @ViewBuilder
    private func makeTabHeader() -> some View {
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

//MARK: - 탭 컨텐츠
private struct TabContentView : View {
    @StateObject var popupVm = BottomPopupViewModel.shared
    @StateObject var modelData = ModelData.modelData
    var record: Record
    @State var text : String

    var tests : detailTab
    
    
    init(record: Record, tests: detailTab){
        self.record = record
        _text = State(initialValue: record.memo)
        self.tests = tests
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            switch tests {
                //MARK: - 음성 녹음
            case .voiceRecord :
                let people = record.people
                
                ForEach(record.allText, id: \.self){string in
                    textRow(number: Int.random(in: 1...people), text: string)
                }
                //MARK: - 메모 요약
            case .memoSummary:
                VStack(alignment: .leading) {
                    if let index = modelData.records.firstIndex(of: self.record){
                        if modelData.records[index].memo.isEmpty{
                            Text("메모를 입력하세요.")
                        }else{
                            Text(modelData.records[index].memo)
                        }
                    }
                }
                .padding(20)
                .onTapGesture {
                    //탭하면 메모 수정가능 - 팝업 올리기
                    popupVm.type = .memo
                    popupVm.isOpen.toggle()
                    
                }
                .onChange(of: modelData.records){newValue in
                    
                }
                
            }
        }

    }
}



private struct textRow : View {
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
