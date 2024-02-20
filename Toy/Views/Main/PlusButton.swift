//
//  CircleButton.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI
import AVFoundation

extension AnyTransition{
    static var moveUp: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .scale.combined(with: move(edge: .bottom)))
    }
}

struct PlusButton: View {
    @Binding var clicked : Bool
    
    var body: some View {
        VStack(alignment: .trailing){
            if clicked {
                Button{
                    
                }label: {
                    Text("녹음")
                        .foregroundStyle(.white)
                    Image(systemName: "mic.circle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 54)
                        )
                    
                }
                .transition(.move(edge: .bottom))
                
                FileUploadButton(clicked: $clicked)
                    .transition(.move(edge: .bottom))
                
                Button{
                    
                }label: {
                    Text("새 노트")
                        .foregroundStyle(.white)
                    Image(systemName: "square.and.pencil.circle.fill")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .foregroundStyle(.black)
                                .frame(width: 54)
                        )
                }
                .transition(.move(edge: .bottom))
              
               
            }
            
            //plus 버튼
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)){
                    clicked.toggle()
                }
            }){
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55) // 버튼 크기 조절
                    .foregroundColor(Color("blackWhite")) // 버튼 색상
                    .rotationEffect(.degrees(clicked ? -45 : 0))
                    .background(
                        Circle()
                            .frame(width: 50)
                            .foregroundStyle(Color("tempColor"))
                    )
            }
            
        }
        .padding()
    }
}

struct FileUploadButton : View {
    @State private var isImporting = false
    @State private var appendSuccess = false
    @State private var error: Error?
    @State private var record : Record?
    @State private var modelData = ModelData.modelData
    @Binding var clicked: Bool
    
    var body: some View {
        HStack(spacing: 15){
            Text("파일 업로드")
                .foregroundStyle(.white)
            
            Image(systemName: "square.and.arrow.up.circle.fill")
                .resizable()
                .frame(width: 55, height: 55)
                .foregroundStyle(.white)
                .background(
                    Circle()
                        .foregroundStyle(.black)
                        .frame(width: 54)
                )
        }
        .onTapGesture {
            isImporting.toggle()
        }
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [.mp3]) { result in
            
            switch result {
            case .success(let url): //성공하면 url이 담김
                let fileName = url.lastPathComponent
                let text = fileName
                let duration = getAudioDuration(url: url)
                
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
    }
}

extension FileUploadButton {
    
    
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
    PlusButton(clicked: .constant(true))
}
