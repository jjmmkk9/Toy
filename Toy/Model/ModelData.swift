//
//  ModelData.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import Foundation
import SwiftUI

@Observable
class ModelData{
    
    static let modelData = ModelData()
    
    var blogBigItems : [BlogBigItem] = [
        BlogBigItem(text: "클로바 노트,\n이럴때 유용해요!", btnColor: Color(red: 219 / 255, green: 208 / 255, blue: 123 / 255), image: "root", isWhite: false, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184902960&proxyReferer="),
        BlogBigItem(text: "새로운 노트를\n만드는 방법!", btnColor: Color(red: 149 / 255, green: 62 / 255, blue: 91 / 255), image: "root", isWhite: true, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184906572&proxyReferer="),
        BlogBigItem(text: "알고 쓰면\n더욱 유용한 기능", btnColor: Color(red: 153 / 255, green: 145 / 255, blue: 145 / 255), image: "root", isWhite: true, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184906572&proxyReferer=")
    ]
    
    var records : [Record] = [Record(id: 1), Record(id: 2), Record(id: 3), Record(id: 4)]
    
    var history: Set<String> = []
    
    var myFolders : [String] = ["기본", "학교"]
    
    var categories : [String: [Record]]{
        Dictionary(
            grouping: records, by: {$0.category}
            )
    }
    
    func updateHistory() -> Set<String> {
        history = []
        for record in records{
            if let createTime = record.createTime{
                let str = dateToString(date: createTime)
                history.insert(str)
            }
        }
        
        print(history)
        return history
    }
    
    
}


