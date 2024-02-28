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
    var record: Record
    @State private var selectedTab: detailTab = .voiceRecord
    @Binding var searchTxt : String
    @Binding var count : Int
    let proxy : ScrollViewProxy
    @Binding var index : Int
    @Binding var searchOpen : Bool
    
    var body: some View {
        VStack {
            makeTabHeader()
            TabContentView(tab: $selectedTab, searchTxt: $searchTxt, count: $count, proxy: proxy, index: $index)
        }
        //        .onChange(of: searchOpen){serchOpen in
        //            if searchOpen{
        //                if selectedTab == .memoSummary{
        //                    selectedTab = .voiceRecord
        //                }
        //            }
        //        }
        //        .onChange(of: selectedTab){selectedTab in
        //            if selectedTab == .memoSummary{
        //                searchOpen = false
        //            }
        //        }
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
    @StateObject private var recordVm = RecordViewModel.shared
    @Binding var tab : detailTab
    
    @Binding var searchTxt : String
    @Binding var count : Int
    @State private var scrollIndex : Int = 0
    let proxy : ScrollViewProxy
    @Binding var index : Int
    
    @State private var indices : [Int] = []
    
    var body: some View {
        
        if let record = recordVm.presented{
            let people = record.people
            let allText = record.allText
            VStack{
                switch tab {
                case .voiceRecord :
                    ForEach(allText.indices, id: \.self){index in
                        let string = allText[index]
                        textRow(number: Int.random(in: 1...people), text: string, count: $count, searchTxt: $searchTxt)
                            .id(index)
                    }
                    
                case .memoSummary:
                    VStack(alignment: .leading) {
                        
                        if record.memo.isEmpty{
                            Text("메모를 입력하세요.")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }else{
                            Text(record.memo)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                    .padding(20)
                    .onTapGesture {
                        popupVm.type = .memo
                        popupVm.isOpen.toggle()
                        
                    }
                    
                }
            }
            .onChange(of: searchTxt){ newTxt in
                if count > 0{
                    self.index = 0
                    self.indices = matchingString(of: newTxt, in: allText)
                    //초기 인덱스 0
                    scroll()
                    
                }else{
                    self.index = -1
                    self.indices = matchingString(of: newTxt, in: allText)
                }
                
                
            }
            .onChange(of: index){newIndex in
                print("newIndex : \(newIndex)")
                scroll()
            }
            
            
        }else{
            Text("recordVm에 정보가 없네요")
        }
        
    }
    
    func matchingString(of substring: String, in strings: [String]) -> [Int] {
        return strings.enumerated().flatMap { index, string in
            let cnt = stringCount(str: string, substring: substring)
            return Array(repeating: index, count: cnt)
        }
    }
    
    func stringCount(str: String, substring: String) -> Int{
        let cnt = str.components(separatedBy: substring).count - 1
        return cnt
    }
    
    func scroll(){
        if !indices.isEmpty{
            scrollIndex = indices[index]
            withAnimation{
                proxy.scrollTo(scrollIndex, anchor: .top)
            }
        }else{
            print("index가 범위를 넘었다능")
        }
    }
}




private struct textRow : View {
    var number: Int
    var text : String
    let colors : [Color] = [.red, .cyan, .purple, .orange, .blue]
    
    @Binding var count : Int
    @Binding var searchTxt : String
    
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
                highlightedText(str: text, searched: searchTxt)
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .onChange(of: searchTxt){newTxt in
            if !newTxt.isEmpty{
                textCount(str: text, searched: newTxt)
            }
        }
    }
    
    func highlightedText(str: String, searched: String) -> Text {
        guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
        
        var result: Text!
        let parts = str.components(separatedBy: searched)
        for i in parts.indices {
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            //검색어가 하나라도 있는경우
            if i != parts.count - 1 {
                result = result + Text(searched).foregroundColor(.red).bold()
            }
        }
        return result ?? Text(str)
    }
    
    //searched가 str에서 몇번 검색되었는지 count 올리기 위한 함수
    //split로 count를 수정하면 취소할때 textCount가 실행되면서 count가 전체 글자수대로 올라가는듯..^^ 왜이래
    func textCount(str: String, searched: String){
        let txtCount = str.components(separatedBy: searched).count - 1
        self.count += txtCount
    }
}

//#Preview {
//    RecordViewModel.shared.presented = ModelData.modelData.records[0]
//    return RecordDetailViewCustomTab(record: ModelData.modelData.records[0],
//                                     searchTxt: .constant("조금"), count: .constant(0), proxy: ScrollViewProxy)
//}
