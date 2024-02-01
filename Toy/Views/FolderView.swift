//
//  FolderView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import SwiftUI

struct FolderView: View {
    var body: some View {
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
        
        ScrollView{
            Button{
                
            }label: {
                
                Image(systemName: "note")
                Text("전체 노트")
//                    .font(.headline)
                Spacer()
                HStack{
                    Button{
                        
                    }label: {
                        Text("+")
                    }
                    .padding(.trailing, 10)
                    Button{
                        
                    }label: {
                        Image(systemName:"arrowtriangle.up")
                    }
                }
                .font(.title)
                
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    FolderView()
}
