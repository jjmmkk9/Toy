//
//  SharedNoteNothing.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI

struct NoteNothingView: View {
    var noteCategory: String
    var body: some View {
        VStack{
            Image(systemName: "link.circle.fill")
                .resizable()
                .foregroundStyle(.purple)
                .frame(width: 25, height: 25)
            Text("\(noteCategory) 노트가 없어요.")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.white)
        )
    }
}

#Preview {
    NoteNothingView(noteCategory: "공유 받은")
}
