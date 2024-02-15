//
//  UsefulFeatures.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI

struct UsefulFeatures: View {
    var body: some View {
        VStack(alignment:.leading, spacing: 30){
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20){
                    Image(systemName: "globe").foregroundStyle(Color("blueSkyItem"))
                    Text("다양한 녹음 언어 지원").foregroundColor(Color("blackWhite")).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "bookmark").foregroundStyle(Color("blueSkyItem"))
                    Text("중요한 순간 북마크").foregroundColor(Color("blackWhite")).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "highlighter").foregroundStyle(Color("blueSkyItem"))
                    Text("강조할 내용 하이라이트").foregroundColor(Color("blackWhite")).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "mic").foregroundStyle(Color("blueSkyItem"))
                    Text("녹음 중 실시간 메모").foregroundColor(Color("blackWhite")).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "envelope").foregroundStyle(Color("blueSkyItem"))
                    Text("이메일 계정에 노트 공유").foregroundColor(Color("blackWhite")).bold()
                    Spacer()
                }
                })
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(RoundedRectangle(cornerRadius: 25.0)
            .foregroundStyle(Color("whiteItemColor"))
                    )
        
        
        
    }
}

#Preview {
    UsefulFeatures()
}
