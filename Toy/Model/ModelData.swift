//
//  ModelData.swift
//  Toy
//
//  Created by 비긴어브랜드 on 2/1/24.
//

import Foundation
import SwiftUI

class ModelData : ObservableObject{
    
    static let modelData = ModelData()
    
    var blogBigItems : [BlogBigItem] = [
        BlogBigItem(text: "클로바 노트,\n이럴때 유용해요!", btnColor: Color(red: 219 / 255, green: 208 / 255, blue: 123 / 255), image: "root", isWhite: false, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184902960&proxyReferer="),
        BlogBigItem(text: "새로운 노트를\n만드는 방법!", btnColor: Color(red: 149 / 255, green: 62 / 255, blue: 91 / 255), image: "root", isWhite: true, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184906572&proxyReferer="),
        BlogBigItem(text: "알고 쓰면\n더욱 유용한 기능", btnColor: Color(red: 153 / 255, green: 145 / 255, blue: 145 / 255), image: "root", isWhite: true, destination: "https://m.blog.naver.com/PostView.naver?blogId=clova_ai&logNo=223184906572&proxyReferer=")
    ]
    
    @Published var records : [Record] = [Record(id: 1), Record(id: 2), Record(id: 3), Record(id: 4)]{
        
        didSet{
            print("Records changed presented ID : \(records.filter{$0.isPresented}.map{$0.id})") //현재 보여주는 record
//            print("Records changed : \(records.map{$0.name})")
        }
    }
    

    
    @Published var myFolders : [String] = ["기본", "학교"]{
        didSet{
            print(myFolders)
        }
    }
    
     var categories : [String: [Record]]{
        Dictionary(
            grouping: records, by: {$0.category}
            )
    }
    
    var history : Set<Date> {
        var set : Set<Date> = []
        for record in ModelData.modelData.records{
            set.insert(record.createTime!)
        }
        print("history setted :::::::::::::::: \(set)")
        return set
    }
    
    func dayRecords(date : Date) -> [Record]{
        let fr = records.filter{
            Calendar.current.isDate(date, inSameDayAs: $0.createTime ?? Date())
        }
        return fr
    }
    
    func appendRecord(_ record : Record) {
        records.append(record)
    print("레코드 추가됨")
    }
    

}



