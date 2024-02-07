//
//  DateDecode.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/7/24.
//

import Foundation

let dateFormatter = DateFormatter()

func stringToDateTime(dateString : String) -> Date? {
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let date = dateFormatter.date(from: dateString)
    return date
}

func editTimeToString(editTime: Date) -> String {
    dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
    let dateStr = dateFormatter.string(from: editTime)
    return dateStr
}
//오후 2:31
func simpleRecordTimeString(createTime : Date) -> String{
    dateFormatter.dateFormat = "a h:mm"
    dateFormatter.locale = Locale(identifier: "ko_KR") //오전 오후
    return dateFormatter.string(from: createTime)
}

func recordDetailTimeString(createTime : Date, editTime: Date) -> String{
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "M.d E HH:mm"
    let createTime = dateFormatter.string(from: createTime)
    dateFormatter.dateFormat = "HH:mm"
    let editTime = dateFormatter.string(from: editTime)
    return "\(createTime) (\(editTime) 수정)"
}

func dateToString(date: Date) -> String {
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let str = dateFormatter.string(from: date)
    return str
}
