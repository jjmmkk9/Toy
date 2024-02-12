//
//  DatePickerView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/7/24.
//

import SwiftUI

struct DatePickerView: View {
    @State private var year = 2024
    @State private var month = 2
    
    @Binding var clicked : Bool
    @Binding var wheelOn : Bool
    //바뀐 날짜
    @State var dateViewModel = DateViewModel.shared
    
    var body: some View {
        Spacer()
            ZStack(alignment: .bottom){
                Color.clear.ignoresSafeArea()
                Rectangle()
                    .frame(height: 50)
                    .foregroundStyle(.white)
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 300)
                    .foregroundStyle(.white)
                    .ignoresSafeArea()
                
                HStack{
                    Picker("select year", selection: $year) {
                        ForEach(2000..<2101, id: \.self) { year in
                            Text("\(String(year))").tag(year)}
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 200)
                    .clipped()
                    
                    Picker("select month", selection: $month) {
                        ForEach(1..<13, id: \.self) { month in
                            Text("\(month)").tag(month)}
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 200)
                    .clipped()
                    
                }
                .frame(height: 200)
                .offset(y: -70)
                
                
                Button{
                    //완료시 changeMonth
                    clicked = false
                    wheelOn = false
                    let date = yearMonthCreate(for: year, month: month)
                    
                    //newMonth = date
                    dateViewModel.newMonth = date
                    
                } label: {
                    Text("완료")
                        .frame(maxWidth: .infinity)
                        .frame(height: 35)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .ignoresSafeArea()
            
        
        
    }
}

#Preview {
    DatePickerView(clicked: .constant(true), wheelOn: .constant(true))
}
