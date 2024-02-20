//
//  ProfileInfoView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI

struct ProfileInfoView: View {
    @StateObject private var profile = UserProfileViewModel.default
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    
    @State private var presentsOptionSheet : Bool = false
    @State private var cameraOpen : Bool = false
    @State private var libraryOpen: Bool = false
    
    func loadImage() {
        guard let selectedUIImage = selectedUIImage else { return }
        profile.image = Image(uiImage: selectedUIImage)
    }
    
    
    var body: some View {
        VStack(spacing:50){
            BackButtonWithHeader("프로필 정보")
            Button{
                presentsOptionSheet.toggle()
            }label: {
                ZStack{
                    if let image = profile.image{
                        image
                            .resizable()
                            .clipShape(Circle())
                            .frame(width:120, height: 120)
                        Circle()
                            .foregroundStyle(Color(UIColor.MyTheme.bgColor))
                            .frame(width: 35)
                            .overlay{
                                Image(systemName: "camera")
                                    .foregroundStyle(.black)
                            }
                            .offset(x: 45, y: 35)
                    }else{
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width:120)
                            .foregroundStyle(.gray)
                        Circle()
                            .foregroundStyle(Color(UIColor.MyTheme.bgColor))
                            .frame(width: 35)
                            .overlay{
                                Image(systemName: "camera")
                                    .foregroundStyle(.black)
                            }
                            .offset(x: 45, y: 35)
                    }
                    
                }
                
            }
            .sheet(isPresented: $showImagePicker, onDismiss: {
                loadImage()
            }){
                ImagePicker(image: $selectedUIImage, isCameraPicker: cameraOpen)
            }
            .actionSheet(isPresented: $presentsOptionSheet, content: {
                ActionSheet(
                    title: Text("이미지 선택"),
                    message: nil,
                    buttons: [
                        .default(
                            Text("camera"),
                            action: {setOpenCamera()}
                        ),
                        .default(
                            Text("Library"),
                            action: {setOpenLibrary()}
                        ),
                        .cancel(
                            Text("cancel"),
                            action: {presentsOptionSheet = false}
                        )
                    ]
                )
            })
            
            
            VStack{
                Text("이름")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
                
                TextField("내 이름",text: $profile.name)
                
                Text("이메일")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.gray)
                TextField("내 이메일",text: $profile.email)
            }
            
            
        }
        .padding( 20)
        Spacer()
        
        
    }
}

extension ProfileInfoView{
    func setOpenCamera(){
        self.cameraOpen = true
        self.libraryOpen = false
        self.presentsOptionSheet = false
        showImagePicker.toggle()
    }
    func setOpenLibrary() {
        self.libraryOpen = true
        self.cameraOpen = false
        self.presentsOptionSheet = false
        showImagePicker.toggle()
    }
}

#Preview {
    ProfileInfoView()
}
