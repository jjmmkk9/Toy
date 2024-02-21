//
//  NoteView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/5/24.
//

import SwiftUI
class RecordViewModel{
    
}

struct NoteView: View {
    @Environment(\.dismiss) var dismiss
    var folder :String
    var isFullNote: Bool = false
    
    var items : [Record] {
        ModelData.modelData.categories[folder] ?? []
    }
    @State private var records = ModelData.modelData.records
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Image(systemName: "arrow.left")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    dismiss()
                }

                Text(folder)
                    .font(.title)
                    .bold()
            
            if records.isEmpty{
                NoteNothingView()
            }else if isFullNote {
                ScrollView{
                    detailOpen(records: $records)
                }
            }else if !items.isEmpty {
                ScrollView{
                    detailOpen(records: $records)
                }
            }else{
                NoteNothingView()
            }
            
            // 중앙 정렬을 위한 Spacer 추가
            Spacer()
        }
        .padding(20)
        .frame(maxHeight: .infinity)
        .background(Color("bgColor"))
        
        
    }
}

private struct NoteNothingView : View{
    var body: some View{
        GeometryReader{ geometry in
            
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
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

#Preview {
    NoteView(folder: ModelData().myFolders[0])
}
