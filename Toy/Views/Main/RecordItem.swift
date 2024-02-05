//
//  RecordItem.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct RecordItem: View {
    var record : Record
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(height: 110)
            .foregroundStyle(.white)
            .overlay(
                HStack{
                    Image(systemName: "mic.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(Color(red: 0, green: 204 / 255, blue: 127 / 255))
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text("\(record.name) \(record.id)")
                            .font(.headline)
                        Text(record.summary)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
                        Text(record.editTimeFormat + " - " + record.totalTimeFormat +  " - 전체 노트")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 100 / 255, green: 100 / 255, blue: 100 / 255))
                    }
                    .padding(10)
                }
                    .padding(10)
            )
        
    }
}

#Preview {
    let modelData = ModelData.modelData
    return RecordItem(record: modelData.records[0])
}
