//
//  SimpleRecordItem.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/7/24.
//

import SwiftUI

struct SimpleRecordItem: View {
    var record : Record
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 110)
            .foregroundStyle(Color("bgItemColor"))
            .overlay(
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(record.name) \(record.id)")
                    HStack(spacing: 5){
                        Image(systemName: "fitness.timer")
                        Text("\(record.simpleTimeString)") //생성 시간
                        Spacer()
                    }
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                }
                    .padding(20)
            )
    }
}

#Preview {
    SimpleRecordItem(record:ModelData.modelData.records[0])
}
