//
//  DoubleExtensions.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/19/24.
//

import Foundation

extension Double{
    var formattedTimeInterval : String {
        let totalSeconds = Int(self)
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
