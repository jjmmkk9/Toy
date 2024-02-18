//
//  InterestingView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI

struct InterestingView: View {
    @State private var selected : Int = 2
    
    let items = ["정치/ 사회", "경제/금융", "IT/과학", "광고/미디어", "교육", "영업", "마케팅","법률", "의료/복지", "문화/예술", "기타치기"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            BackButtonWithHeader("관심 분야")
            
            Text("종사하고 계신 분야나 자주 사용하는 분야를 설정하면 서비스 품질 개선에 도움이 됩니다.")
                .font(.body)
            
            RadioButtonGroup(items: items, selected: $selected, callback: {(_, _) in })
            Spacer()
        }
        .padding(20)
    }
}

#Preview {
    InterestingView()
}
