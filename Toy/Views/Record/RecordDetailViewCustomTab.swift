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
                //count 초기화
                self.count = 0
                self.index = 0
                
                self.indices = matchingString(of: newTxt, in: allText)
                print(indices)
                //초기 인덱스 0
                if !indices.isEmpty{
                    scrollIndex = indices[index]
                    withAnimation{
                        proxy.scrollTo(scrollIndex, anchor: .top)
                        print("\(scrollIndex) 로 이동")
                    }
                }else{
                    print("index가 범위를 넘었다능")
                }
                
            }
            .onChange(of: index){newIndex in
                scrollIndex = indices[newIndex] //스크롤할 인덱스를 담은 배열에 접근
                withAnimation{
                    proxy.scrollTo(scrollIndex, anchor: .top)
                    print("\(scrollIndex) 로 이동")
                }
            }
            
            

        }else{
            Text("recordVm에 정보가 없네요")
        }
        
    }
    
    func matchingString(of substring: String, in strings : [String]) -> [Int]{
        //string을 [string]에서 찾아 그리고 찾아진 녀석들의 인덱스를 담아서 반환
        strings.enumerated().filter{index, string in
            string.contains(substring)
        }.map{$0.0}
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
            textCount(str: text, searched: newTxt)
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
    
    func textCount(str: String, searched: String){
        let components = str.components(separatedBy: searched)
        let num = components.count - 1
        print(num)
        self.count += num
    }
}

//#Preview {
//    RecordViewModel.shared.presented = ModelData.modelData.records[0]
//    return RecordDetailViewCustomTab(record: ModelData.modelData.records[0],
//                                     searchTxt: .constant("조금"), count: .constant(0), proxy: ScrollViewProxy)
//}
