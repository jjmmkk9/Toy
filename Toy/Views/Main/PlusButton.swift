//
//  CircleButton.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import SwiftUI

extension AnyTransition{
    static var moveUp: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .bottom), removal: .scale.combined(with: move(edge: .bottom)))
    }
}

struct PlusButton: View {
    
    @State private var fileClick : Bool = false
    @Binding var clicked : Bool
    
    @State private var clickButton : Bool = false
    
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
                        
                        fileClick.toggle()
                        clicked = false
                    }
                    .sheet(isPresented: $fileClick, content: {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
                    })
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

#Preview {
    PlusButton(clicked: .constant(true))
}
