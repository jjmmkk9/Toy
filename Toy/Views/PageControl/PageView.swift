//
//  PageView.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0
    
    var body: some View {
//        ZStack{
//            Color(red: 247/255, green: 247/255, blue: 247/255)
//            PageViewController(pages: pages, currentPage: $currentPage)
//            PageControl(numberOfPages: pages.count, currentPage: $currentPage)
//                .offset(y:90)
//        }
//        .aspectRatio( 4 / 2, contentMode: .fit)
        
            
        VStack {
                PageViewController(pages: pages, currentPage: $currentPage)
                .aspectRatio(5 / 2,contentMode: .fit)
                PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                    
                }
//        .background(.blue)
//                .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                
    }
}

#Preview {
    PageView(pages: blogBigItems)
}
