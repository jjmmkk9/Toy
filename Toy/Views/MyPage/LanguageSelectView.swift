//
//  LanguageSelectView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI

struct LanguageSelectView: View {
    let items = ["한국어", "한국어 + 영어", "영어", "일본어", "중국어(간체)", "중국어(번체)"]
    @State private var selected : Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            BackButtonWithHeader("인식 언어")
            
            Text("음성 인식 언어를 선택해 주세요\n선택한 언어로 음성 기록이 변환됩니다.")
                .font(.body)
            
            RadioButtonGroup(items: items, selected: $selected , callback: {(_, _) in })
            Spacer()
        }
        .padding(20)
    }
}
struct RadioButtonGroup: View {
    var items: [String]
    @Binding var selected : Int
    
    let callback: ((Int, Int)) -> ()
    
    func radioGroupCallback(id: Int){
        callback((selected, id))
        selected = id
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            ForEach(Array(items.enumerated()), id: \.offset){ idx, item in
                RadioButton(id: idx, title: item, callback: self.radioGroupCallback, selected: self.selected)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(Color("blackWhite"))
    }
}

struct RadioButton: View {
    let window = UIScreen.main.bounds.size
    let id : Int
    let title: String
    let callback: (Int) -> ()
    let selected: Int
    
    init(id: Int, title: String, callback: @escaping (Int) -> (), selected: Int) {
        self.id = id
        self.title = title
        self.callback = callback
        self.selected = selected
    }
    
    var body: some View {
        Button{
            self.callback(id)
        }label: {
            if selected == id{
                Circle()
                    .frame(width: 20)
                    .foregroundStyle(.blue)
                    .overlay{
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 10)
                    }
            }else{
                Circle()
                    .stroke()
                    .frame(width: 20)
            }
                
            Text(title)
                .fontWeight(.bold)
        }
    }
}

//#Preview {
//    LanguageSelectView()
//}
