//
//  AudioUploadView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI

struct AudioUploadView: View {
    @State private var text = ""
    @State private var error: Error?
    @State private var isImporting = false
    
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
            case .success(let url):
                let fileName = url.lastPathComponent
                print("fileName : \(fileName)")
              self.text = fileName
            case .failure(let error):
              self.error = error
            }
          }
    }
}


#Preview {
    AudioUploadView()
}
