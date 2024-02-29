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

    let proxy : ScrollViewProxy

    
    var body: some View {
        VStack {
            makeTabHeader()
            TabContentView(tab: $selectedTab, proxy: proxy)
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
    @StateObject var searchVm = SearchViewModel.shared
    @State private var scrollIndex : Int = 0
    
    @State private var counts : [Int:Int] = [:]
    let proxy : ScrollViewProxy
    
    
    var body: some View {
        
        if let record = recordVm.presented{
            let people = record.people
            let allText = record.allText
            VStack{
                switch tab {
                case .voiceRecord :
                    ForEach(allText.indices, id: \.self){index in
                        let string = allText[index]
                        textRow(number: Int.random(in: 1...people), text: string, rowIndex: index)
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
            .onChange(of: searchVm.searchTxt){ newTxt in
                if searchVm.count > 0{
                    scroll()

                }else{
                    searchVm.index = -1
                    searchVm.indices = []
                }
                
                
            }
            .onChange(of: searchVm.index){newIndex in
                //TODO: - 인덱스 변경될때마다 substring 각자의 index 위치(?) 아무튼 그 부분에 배경색 변경
                
                print("newIndex : \(newIndex)")
                scroll()
            }
            
            
        }else{
            Text("recordVm에 정보가 없네요")
        }
        
    }
    
    func scroll(){
        if !searchVm.indices.isEmpty{
            scrollIndex = searchVm.indices[searchVm.index]
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
    
    @StateObject var searchVm = SearchViewModel.shared
    var rowIndex : Int
    
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
                highlightedText(str: text, searched: searchVm.searchTxt)

            }
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .onChange(of: searchVm.searchTxt){newTxt in
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
            //searched를 기준으로 잘린 부분 i result에 넣고
            result = (result == nil ? Text(parts[i]) : result + Text(parts[i]))
            
            if i != parts.count - 1 {
                print("indices in textRow : \(searchVm.indices)")
                //searched를 attributedString으로 색칠해서 result에 더하기
                if searchVm.indices[searchVm.index] == rowIndex {
                    var txt = AttributedString(searched)
                    txt.backgroundColor = .red
                    txt.foregroundColor = .white
                    result = result + Text(txt)
                }else{
                    var txt = AttributedString(searched)
                    txt.backgroundColor = .yellow
                    txt.foregroundColor = .red
                    result = result + Text(txt)
                }
            }
        }
        return result ?? Text(str)
    }
    
    //searched가 str에서 몇번 검색되었는지 count 올리기 위한 함수
    //split로 count를 수정하면 취소할때 textCount가 실행되면서 count가 전체 글자수대로 올라가는듯..^^ 왜이래
    func textCount(str: String, searched: String){
        let txtCount = str.components(separatedBy: searched).count - 1
        searchVm.count += txtCount
    }
}

//#Preview {
//    RecordViewModel.shared.presented = ModelData.modelData.records[0]
//    return RecordDetailViewCustomTab(record: ModelData.modelData.records[0],
//                                     searchTxt: .constant("조금"), count: .constant(0), proxy: ScrollViewProxy)
//}
