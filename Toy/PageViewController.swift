//
//  PageViewController.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/31/24.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {

    var pages: [Page]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(pageviewController: self)
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
        pageViewController.dataSource = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            //컨트롤러에 swiftui 뷰를 삽입하는 방법 - setViewControllers
            [context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
        var parent: PageViewController
        
        var controllers = [UIViewController]()
    
        init(pageviewController: PageViewController) {
            parent = pageviewController
            controllers = parent.pages.map {UIHostingController(rootView: $0)}
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0{
                return nil
            }
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else{
                return nil
            }
            if index + 1 == controllers.count{ //마지막페이지면
                return nil //멈춰!
            }
            return controllers[index + 1]// index + 1
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController){
                //currentPage에 index를 바인딩으로 넘겨준다
                parent.currentPage = index
            }
        }
        
    }
    
    
}
