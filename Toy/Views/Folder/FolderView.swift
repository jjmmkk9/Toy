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
                    
                    Button{
                        //code
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 23))
                    }
                }
                .foregroundColor(.black)
                .padding(.vertical, 20)
                
                VStack(alignment: .leading, spacing: 20){
                    
                    NavigationLink {
                        NoteView(folder: "전체 노트", isFullNote: true)
                    } label: {
                        Image(systemName: "note")
                        Text("전체 노트")
                        Spacer()
                        HStack{
                            Button{
                                //전체노트 + 버튼 클릭시
                            }label: {
                                Text("+")
                            }
                            .padding(.trailing, 10)
                            .foregroundStyle(.secondary)
                            
                            Button{
                                // 전체 노트 접고 펴기
                                isNoteOpen.toggle()
                            }label: {
                                Image(systemName:isNoteOpen ? "arrowtriangle.up" : "arrowtriangle.down")
                            }
                            .foregroundStyle(.secondary)
                        }
                        .font(.title)
                    }

                    
                    //전체폴더! 접고 펼때 나타나는 폴더만 패딩 .leading 20
                    if isNoteOpen {
                        VStack(spacing: 20){
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
                    
                    
                    Button{
                        //공유받은 노트 클릭시 ㄱㄱ
                    }label: {
                        Image(systemName: "note")
                        Text("공유 받은 노트")
                        
                        Spacer()
                        HStack{
                            Button{
                                //전체노트 + 버튼 클릭시
                            }label: {
                                Text("+")
                            }
                            .padding(.trailing, 10)
                            .foregroundStyle(.secondary)
                            
                            Button{
                                // 전체 노트 접고 펴기
                            }label: {
                                Image(systemName:"arrowtriangle.down")
                            }
                            .foregroundStyle(.secondary)
                            
                        }
                        .font(.title)
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
                .foregroundStyle(.black)
                
                
                
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    FolderView()
}
