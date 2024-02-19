//
//  FolderView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import SwiftUI

struct FolderView: View {
    @State private var isNoteOpen : Bool = false
    @State private var isSharedNoteOpen : Bool = false
    
    
    var vm = PopupViewModel.shared
    
    var myFolders : [String] = ModelData.modelData.myFolders
    var body: some View {
        
        
        NavigationStack{
            
            ScrollView{
                //header
                HStack{
                    Text("폴더")
                        .bold()
                        .font(.title2)
                    Spacer()
                    
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23))
                    
                }
                .padding(.vertical, 20)
                
                VStack(alignment: .leading, spacing: 20){
                    HStack{
                        NavigationLink {
                            NoteView(folder: "전체 노트", isFullNote: true)
                        } label: {
                            Image(systemName: "note")
                            Text("전체 노트")
                        }
                        Spacer()
                        
                        Button{
                            //전체노트 + 버튼 클릭시
                            vm.type = "folder"
                            vm.isOpen.toggle()
                        }label: {
                            Text("+")
                                .font(.title)
                                .padding(.trailing, 10)
                                .foregroundStyle(.gray)
                        }
                        Button{
                            // 전체 노트 접고 펴기
                            isNoteOpen.toggle()
                        }label: {
                            Image(systemName:isNoteOpen ? "chevron.up" : "chevron.down")
                                .font(.title)
                                .foregroundStyle(.gray)
                        }
                    }
                        

                    //접고 펼때 나타나는 폴더만 패딩 .leading 20
                    if isNoteOpen {
                        VStack(alignment: .leading, spacing: 20){
                            ForEach(myFolders, id: \.self){folder in
                                NavigationLink{
                                    NoteView(folder: folder)
                                }label: {
                                    Image(systemName: "folder")
                                    Text(folder)
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .navigationDestination(for: String.self){ folder in
                            NoteView(folder: folder)
                        }
                    }
                    
                    HStack{
                        NavigationLink {
                            NoteView(folder: "공유 받은 노트")
                        } label: {
                            Image(systemName: "note")
                            Text("공유 받은 노트")
                        }
                        Spacer()
                        
                        Button{
                            
                        }label: {
                            Text("+")
                                .font(.title)
                                .padding(.trailing, 10)
                                .foregroundStyle(.gray)
                        }
                        Button{
                            // 전체 노트 접고 펴기
                            
                        }label: {
                            Image(systemName:isNoteOpen ? "chevron.up" : "chevron.down")
                                .font(.title)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                        Text("공유한 노트")
                    }
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                        Text("휴지통")
                    }
                }
                .foregroundStyle(Color("blackWhite"))
                
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    FolderView()
}
