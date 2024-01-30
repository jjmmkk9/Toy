//
//  Record.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/30/24.
//

import Foundation

struct Record {
    var name : String = "회의"
    var summary : String = "국가는 농지에 관하여 경자유전의 원칙이 달성될 수 있도록 노력하여야 하며, 농지의 소작제도는 금지된다. 선거에 있어서 최고득표자가 2인 이상인 때에는 국회의 재적의원 과반수가 출석한 공개회의에서 다수표를 얻은 자를 당선자로 한다."
    private var totalTime : Int = 3035
    var totalTimeFormat : String {
        return "\(totalTime / 60 ) 분 \(totalTime % 60) 초"
    }
    private var editTime : Date = Date()
    var editTimeFormat : String {
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        return formatter.string(from: editTime)
    }
    
    let formatter = DateFormatter()
    
    static let `default` = Record()
    
    //name, summary, totalTimeFormat, editTimeFormat
    
//    func timeFormat(editTime : Date) -> String{
//        formatter.dateFormat = "yyyy.MM.dd HH:mm"
//        
//        return formatter.string(from: editTime)
//    }
    
}
