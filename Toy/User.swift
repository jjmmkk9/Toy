//
//  UserModel.swift
//  Toy
//
//  Created by 비긴어브랜드 on 1/23/24.
//

import Foundation


struct User:Hashable, Decodable, Identifiable{
    var id : Int
    var username : String
    var password : String
    var email : String
    
}
