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
            .foregroundStyle(Color("whiteItemColor"))
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
                            .foregroundStyle(Color("script"))
                        Text(record.editTimeString + " - " + record.totalTimeString +  " - 전체 노트")
                            .font(.system(size: 14))
                            .foregroundStyle(Color("script"))
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
