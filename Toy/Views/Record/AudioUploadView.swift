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
        VStack {
            TextEditor(text: $text)
                .padding()
        }
        .toolbar {
            ToolbarItem() {
                Button {
                    isImporting = true
                } label: {
                    Label("Import file",
                          systemImage: "square.and.arrow.down")
                }
            }
        }
        .fileImporter(isPresented: $isImporting,
                        allowedContentTypes: [.text]) {
            let result = $0.flatMap { url in
              read(from: url)
            }
            switch result {
            case .success(let text):
              self.text += text
            case .failure(let error):
              self.error = error
            }
          }
    }
}
#Preview {
    AudioUploadView()
}
