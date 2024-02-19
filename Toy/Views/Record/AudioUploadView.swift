//
//  AudioUploadView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI
import AVFoundation

struct AudioUploadView: View {
    @State private var text = ""
    @State private var error: Error?
    @State private var isImporting = false
    @State private var appendSuccess = false
    
    @State private var record : Record?
    
    @State private var duration : String = ""
    
    @State private var modelData = ModelData.modelData
    
    var body: some View {
        Button {
            isImporting = true
        } label: {
            Label("Import file",
                  systemImage: "square.and.arrow.down")
        }
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.mp3]) { result in
            
            switch result {
            case .success(let url): //성공하면 url이 담김
                let fileName = url.lastPathComponent
                self.text = fileName
                let duration = getAudioDuration(url: url)
                self.duration = duration?.formattedTimeInterval ?? "duration이 nil이냐"
                
                let record = Record(id: 5, name: fileName, totalTime: Int(duration ?? 0), createTime: Date())
                self.record = record
                modelData.appendRecord(record) // 추가 완료
                appendSuccess = true
            case .failure(let error):
                self.error = error
            }
        }
                      .fullScreenCover(isPresented: $appendSuccess, content: {
                          if let record = record {
                              RecordDetailView(record: record)
                          }else{
                              fatalError("레코드 정보가 존재하지 않습니다.")
                          }
                          
                      })
        
        
        Text(text)
            .font(.title)
        Text(duration)
    }
}

extension AudioUploadView{
    
    private func getAudioDuration(url: URL) ->  TimeInterval? {
        do {
            // AVURLAsset를 사용하여 오디오 파일의 메타데이터를 가져옴
            let asset = AVURLAsset(url: url)
            // AVAsset의 duration 프로퍼티를 사용하여 재생 시간을 가져옴
            let duration = asset.duration
            // CMTime을 TimeInterval로 변환하여 반환
            return TimeInterval(CMTimeGetSeconds(duration))
        }
    }
    
}



#Preview {
    AudioUploadView()
}
