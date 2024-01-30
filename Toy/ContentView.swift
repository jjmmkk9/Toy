//
//  ContentView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @State var selected : Tab = .home
    
    var body: some View {
        
        switch selected {
            
        case .home:
            ClovaMain()
        case .folder:
        Text("folder")
        case .calender:
            Text("calender")
        case .myPage:
            Text("myPage")
        }
        
        Spacer()
        
        Divider()
        CustomTabView(selected: $selected)
            .padding(.bottom, -10)
    }
}

#Preview {
    ContentView()
}
