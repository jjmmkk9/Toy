//
//  ProfileInfoView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/14/24.
//

import SwiftUI

struct ProfileInfoView: View {
    @State private var profile : UserProfile = UserProfile.default
    
    @State var showImagePicker = false
    @State var selectedUIImage: UIImage?
    
    func loadImage() {
            guard let selectedImage = selectedUIImage else { return }
        profile.image = Image(uiImage: selectedImage)
        }
    
    
    var body: some View {
        VStack(spacing:50){
            BackButtonWithHeader("프로필 정보")
            Button{
                showImagePicker.toggle()
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
                ImagePicker(image: $selectedUIImage)
            }
            
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


#Preview {
    ProfileInfoView()
}