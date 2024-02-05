//
//  NoteView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/5/24.
//

import SwiftUI

struct NoteView: View {
    var folder :Folder
    var modelData = ModelData()
    
    var body: some View {
        VStack{
            HStack {
                Text("\(folder.name) 폴더")
                    .font(.title)
                    .bold()
                    
                Spacer()
            }
            
            if let data = modelData.categories[folder.name]{
                ScrollView{
                    ForEach(data, id: \.id){
                        RecordItem(record: $0)
                    }
                }
            }else {
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
                

            
            
            // 중앙 정렬을 위한 Spacer 추가
            Spacer()

            
        }
        .padding(20)
        .frame(maxHeight: .infinity)
        .background(Color(red: 246 / 255, green: 247 / 255, blue: 246 / 255))


    }
}

#Preview {
    NoteView(folder: ModelData().myFolders[0])
}
