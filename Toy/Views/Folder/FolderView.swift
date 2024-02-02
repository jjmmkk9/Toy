//
//  FolderView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import SwiftUI

struct FolderView: View {
    var myFolders : [String] = ModelData().myFolders
    var body: some View {
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
        .padding( 20)
        
        Spacer()
        
        //contents
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                
                Button{
                    //전체 노트 클릭시
//                    전체 페이지 보여주삼
                }label: {
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
                        }label: {
                            Image(systemName:"arrowtriangle.up")
                        }
                        .foregroundStyle(.secondary)
                    }
                    .font(.title)
                    
                }
                
                //접고 펼때 나타나는 폴더만 패딩 .leading 20
            
                
                
                
                
                
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
                            Image(systemName:"arrowtriangle.up")
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

#Preview {
    FolderView()
}
