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
    
    @StateObject var popupVm = BottomPopupViewModel.shared
    @StateObject var modelData = ModelData.modelData
    
    @State private var searchOpen : Bool = false
    @State private var searchTxt : String = ""
    @State private var count : Int = 0
    @State private var index : Int = 0
    
    enum Tab: Hashable {
        case voiceRecord
        case memoSummary
    }
    
    var body: some View {
        
        ZStack {
            //content
            VStack{
                //header
                if searchOpen{
                    SearchBar(isOpen: $searchOpen,
                              searchTxt: $searchTxt,
                              count: $count, index: $index)
                        .shadow(color: .gray.opacity(0.2) ,radius: 5)
                }else{
                    HStack(spacing: 15){
                        Button{
                            dismiss()
                        }label: {
                            Image(systemName: "xmark")
                        }
                        
                        Spacer()
                        
                        Button{
                                searchOpen = true

                        }label: {
                            Image(systemName: "magnifyingglass")
                        }
                        Button{
                            popupVm.type = .removeOrTransfer
                            popupVm.isOpen.toggle()
                        }label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90.0))
                        }
                    }
                    .font(.title2)
                    .padding(20)
                    .padding(.trailing, -10)
                    .foregroundStyle(Color("blackWhite"))
                }
                
                
                //scrollView
                ScrollView{
                    ScrollViewReader{proxy in
                        //info
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(record.detailTimeString) . \(record.totalTimeString)")
                            Text("\(record.name) \(record.id)")
                                .font(.title)
                                .bold()
                            
                            Button{
                                
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
                        
                        RecordDetailViewCustomTab(record: record, searchTxt: $searchTxt, count: $count, proxy: proxy, index: $index, searchOpen: $searchOpen)
                    }
                }
                
            }//vstack close
            .zIndex(1.0)
            
            //MARK: - POPUP
            if popupVm.isOpen{
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .zIndex(2.0)
                    .onTapGesture {
                        popupVm.isOpen.toggle()
                    }
                BottomPopup{
                    switch popupVm.type {
                    case .removeOrTransfer:
                        RemoveOrTransferPopupView()
                    case .memo:
                        MemoPopupView(text: record.memo)
                    default:
                        EmptyView()
                    }
                }
                .zIndex(3.0)
            }
            
        }//zstack close - animation은 팝업을 호출하는 Zstack에 써야한다.
        .animation(.smooth(duration: 0.5), value: popupVm.isOpen)
        .onChange(of: popupVm.isRemove) { isRemove in
            if isRemove{
                appendTrash()
            }
        }
    }
}

extension RecordDetailView{
    func deleteRecord() {
        appendTrash()
        modelData.records.removeAll(where: {modelData.trash.contains($0)})
        print("디테일 삭제완")
    }
    func appendTrash(){
        if let record = modelData.records.first(where: {$0.id == self.record.id}){
            modelData.trash.append(record)
        }else{return}
        dismiss()
    }
    
    //휴지통으로 이동했습니다 토스트?

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
    RecordViewModel.shared.presented = modelData.records[0]
    return RecordDetailView(record: modelData.records[0])
}
