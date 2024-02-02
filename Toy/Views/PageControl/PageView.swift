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
        VStack {
                PageViewController(pages: pages, currentPage: $currentPage)
                .frame(height: 180)
                PageControl(numberOfPages: pages.count, currentPage: $currentPage)
                .offset(y: -10)
                }
    
    }
}

#Preview {
    PageView(pages: ModelData().blogBigItems)
}
