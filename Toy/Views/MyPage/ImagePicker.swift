//
//  ImagePicker.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/16/24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    var isCameraPicker : Bool
    
    @Environment(\.presentationMode) var mode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        if isCameraPicker {
            picker.sourceType = .camera
        }else{
            picker.sourceType = .photoLibrary
        }
//        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension ImagePicker {
    //coordinator 추가 - NSObject, delegate들 상속
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        //parent에 parent 저장
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }
            parent.image = image
            parent.mode.wrappedValue.dismiss()
        }
    }

}


