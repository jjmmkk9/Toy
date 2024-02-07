//
//  DatePickerView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/7/24.
//

import SwiftUI

struct DatePickerView: View {
    @State private var selected = 2024
    var body: some View {
        ZStack(alignment: .bottom){
            
//            DatePicker("", selection: $selected, displayedComponents: .date)
//            .datePickerStyle(WheelDatePickerStyle())
            Picker("select year", selection: $selected) {
                ForEach(2000..<2101, id: \.self) { year in
                    Text("\(year)").tag(year)}
            }
            .pickerStyle(.wheel)
//            Rectangle()
//                .frame(height: 100)
//            RoundedRectangle(cornerRadius: 25)
//                .frame(height: 300)
            
        }
        
        
    }
}

#Preview {
    DatePickerView()
}
