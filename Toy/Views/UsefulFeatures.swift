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
                    Image(systemName: "globe").foregroundStyle(.blue)
                    Text("다양한 녹음 언어 지원").foregroundColor(.black).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "bookmark").foregroundStyle(.blue)
                    Text("중요한 순간 북마크").foregroundColor(.black).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "highlighter").foregroundStyle(.blue)
                    Text("강조할 내용 하이라이트").foregroundColor(.black).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "mic").foregroundStyle(.blue)
                    Text("녹음 중 실시간 메모").foregroundColor(.black).bold()
                    Spacer()
                }
                })
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                HStack(spacing : 20) {
                    Image(systemName: "envelope").foregroundStyle(.blue)
                    Text("이메일 계정에 노트 공유").foregroundColor(.black).bold()
                    Spacer()
                }
                })
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(RoundedRectangle(cornerRadius: 25.0)
            .foregroundStyle(.white)
                    )
        
        
        
    }
}

#Preview {
    UsefulFeatures()
}
