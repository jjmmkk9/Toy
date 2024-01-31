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
        PageViewController(pages: pages, currentPage: $currentPage)
            .aspectRatio( 4 / 2, contentMode: .fit)
            
//            .backGround(Color(red: 247/255, green: 247/255, blue: 247/255))
    }
}

#Preview {
    PageView(pages: [BlogBigItem(), BlogBigItem(), BlogBigItem()])
}
