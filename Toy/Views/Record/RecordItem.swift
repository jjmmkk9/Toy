//
//  RecordItem.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

struct RecordItem: View {
    @Binding var record : Record
    @Binding var records : [Record]
    
    @StateObject var recordVm = RecordViewModel.shared
    @StateObject var modelData = ModelData.modelData
    
    var body: some View {
        ZStack{
            //deleteButton
            HStack{
                Spacer()
                Button {
                    withAnimation(.easeIn){
                        deleteRecord()
                    }
                } label: {
                    Image(systemName: "trash")
                        .font(.title2)
                        .foregroundStyle(.blue)
                        .frame(width: 80, height: 110)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                }

            }
            .padding(.trailing, 10)
            
            //item
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
            .frame(height: 110)
            .padding(10)
            .background(Color("whiteItemColor"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .offset(x: record.offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            .onTapGesture {
                recordVm.presented = record
            }
            .fullScreenCover(item: $recordVm.presented, content: {record in
                RecordDetailView(record: record)
            })

        }
        //zstack end
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.width < 0 {
            if record.isSwiped{
                record.offset = value.translation.width - 90
            }else{
                record.offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value){
        withAnimation(.easeOut){
            if value.translation.width < 0 {
                if -record.offset > 50 {
                    record.isSwiped = true
                    record.offset = -90
                }else{
                    record.isSwiped = false
                    record.offset = 0
                }
            }else{
                record.isSwiped = false
                record.offset = 0
            }
        }
    }
    
    func deleteRecord() {
        //record를 받고 bool 값을 반환, 현재 binding 받은 record id랑 일치하는 record를 records에서 삭제해라
        setRecordOffset()
        appendTrash()
        records.removeAll{ (record) -> Bool in
            return self.record.id == record.id
        }
        
    }
    func appendTrash(){
        if let record = records.first(where: {$0.id == self.record.id}){
            modelData.trash.append(record)
        }else{return}
    }
    func setRecordOffset() {
        self.record.isSwiped = false
        self.record.offset = 0
    }
}

#Preview {
    let modelData = ModelData.modelData
    return RecordItem(record: .constant(modelData.records[0]), records: .constant(modelData.records))
}
