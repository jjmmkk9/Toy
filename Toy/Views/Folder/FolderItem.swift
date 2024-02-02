//
//  FolderItem.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/2/24.
//

import SwiftUI

struct FolderItem: View {
    var folderName : String
    var body: some View {
        Button{
            
        }label: {
            Image(systemName: "folder")
            Text(folderName)
        }
        .padding(.leading, 20)
    }
}

#Preview {
    FolderItem(folderName: "기본폴더")
}
