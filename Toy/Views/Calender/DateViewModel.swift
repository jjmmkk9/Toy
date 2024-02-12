//
//  DateViewModel.swift
//  Toy
//
//  Created by 조문기 on 2/12/24.
//

import SwiftUI

@Observable class DateViewModel{
    static let shared = DateViewModel()
    
    var newMonth : Date = Date()
    
    func updateNewMonth(){
        print("update new month --- DateViewModel.swift")
    }
    
}
