//
//  User.swift
//  01-table
//
//  Created by GREGORY PETROV on 26/11/2020.
//

import Foundation



//class User{
//    var id:Int?
//    var name: String?
//    var userName: String?
//    var email: String?
//    var phoneNumber : Int?
//
//    init(id:Int? ,name:String?, userName:String?, email:String?, phoneNumber:Int?) {
//        self.id = id
//        self.name = name
//        self.userName = userName
//        self.email = email
//        self.phoneNumber = phoneNumber
//
//    }
//}


struct User: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email = "email"
    }

    let id: Int
    let name: String
    let username: String
    let email: String
    
        init(id:Int? ,name:String?, username:String?, email:String?) {
            self.id = id ?? 0
            self.name = name ?? ""
            self.username = username ?? ""
            self.email = email ?? ""
    
        }
}
