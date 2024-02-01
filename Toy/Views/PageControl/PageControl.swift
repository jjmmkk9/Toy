//
//  PageControl.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable{
    var numberOfPages: Int
    @Binding var currentPage: Int
     
    func makeCoordinator() -> Coordinator {
        Coordinator(control: self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPage = 0
        
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged)
        control.currentPageIndicatorTintColor = UIColor.darkGray
        control.pageIndicatorTintColor = UIColor.gray
        
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    
    class Coordinator: NSObject{
        var control: PageControl
        
        init(control: PageControl) {
            self.control = control
        }
        
        @objc
        func updateCurrentPage(sender: UIPageControl){
            //control에 저장된 페이지를
            control.currentPage = sender.currentPage
        }
    }
}
