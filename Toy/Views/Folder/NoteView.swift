//
//  NoteView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/5/24.
//

import SwiftUI

struct NoteView: View {
    var folder :String
    var isFullNote: Bool = false
    
    var items : [Record] {
        ModelData.modelData.categories[folder] ?? []
    }
    @State private var records : [Record] = ModelData.modelData.records
    
    var body: some View {
        VStack{
            HStack {
                Text(folder)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            if records.isEmpty{
                NoteNothingView()
            }else if isFullNote {
                ScrollView{
                    ForEach(records.indices){index in
                        RecordItem(record: records[index])
                            .onTapGesture {
                                records[index].isPresented.toggle()
                            }
                            .fullScreenCover(isPresented: $records[index].isPresented, content: {
                                RecordDetailView(record: records[index])
                            })
                    }
                }
            }else if !items.isEmpty {
                ScrollView{
                    ForEach(items.indices){index in
                        let record = items[index]
                        RecordItem(record: record)
                            .onTapGesture {
                                records[index] = record
                                records[index].isPresented.toggle()
                            }
                            .fullScreenCover(isPresented: $records[index].isPresented, content: {
                                RecordDetailView(record: record)
                            })
                    }
                }
            }else{
                NoteNothingView()
            }
            
            // 중앙 정렬을 위한 Spacer 추가
            Spacer()
        }
        .padding(20)
        .frame(maxHeight: .infinity)
        .background(Color(UIColor.MyTheme.bgColor))
        
        
    }
}

private struct NoteNothingView : View{
    var body: some View{
        VStack(spacing: 10){
            Image("manWithPencil")
                .resizable()
                .scaledToFit()
                .frame(width: 100)
            Text("노트를 만들어 보세요.")
                .font(.title2)
                .bold()
            Text("녹음을 하거나 파일을 업로드하면")
            Text("텍스트로 확인할 수 있어요.")
        }
        .padding(.top, 180)
    }
}

#Preview {
    NoteView(folder: ModelData().myFolders[0])
}
