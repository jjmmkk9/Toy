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
    @Binding var count : Int
    @Binding var index : Int
    
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
                        .onTapGesture {
                            //index를 내리기 - 위로
                            indexDown(count: count)
                            
                        }
                    Text("  \(index + 1) / \(count)  ")
                        .font(.title3)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .onTapGesture {
                            //index를 올리기 - 아래로
                            indexUp(count: count)
                        }
                }
                .padding([.horizontal, .bottom], 20)
            }
        }
        .background(Color("tempColor"))
    }
    
    func indexUp(count: Int){
        if index < count - 1{
            self.index += 1
        }else{
            self.index = 0
        }
        
    }
    func indexDown(count: Int){
        if index == 0 {
            self.index = count - 1
        }else{
            self.index -= 1
        }
    }
}

#Preview {
    SearchBar(isOpen: .constant(true), searchTxt: .constant(""), count: .constant(1), index: .constant(0))
}
