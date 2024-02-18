//
//  DateViewModel.swift
//  Toy
//
//  Created by 조문기 on 2/12/24.
//

import SwiftUI

class DateViewModel : ObservableObject{
    static let shared = DateViewModel()
    
    @Published var newMonth : Date = Date()

}
