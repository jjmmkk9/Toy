//
//  SearchBar.swift
//  Toy
//
//  Created by 조문기 on 2/25/24.
//

import SwiftUI

struct SearchBar: View {
    @State private var text = ""
    @Binding var isOpen : Bool
    @Binding var searchTxt : String
    
    var body: some View {
        VStack(spacing: 10){
            
            HStack(alignment: .center){
                HStack{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.gray)
                    TextField("음성 기록 검색", text: $text)
                        .onSubmit {
                            searchTxt = text
                        }
                    Spacer()
                    if !text.isEmpty{
                        Button{
                            text = ""
                        }label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .frame(height: 50)
                        .foregroundStyle(.gray)
                    
                )
                .padding(10)
                Text("취소")
                    .onTapGesture {
                        //TODO: - 취소하기
                        withAnimation{
                            isOpen = false
                        }
                    }
            }
            .padding(.horizontal, 10)
            if !searchTxt.isEmpty{
                HStack{
                    Spacer()
                    Image(systemName: "chevron.up")
                        .font(.title3)
                    Text("  14 / 14  ")
                        .font(.title3)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                }
                .padding([.horizontal, .bottom], 20)
            }
        }
        .background(Color("tempColor"))
    }
}

#Preview {
    SearchBar(isOpen: .constant(true), searchTxt: .constant(""))
}
