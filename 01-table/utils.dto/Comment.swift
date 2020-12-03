//
//  Comment.swift
//  01-table
//
//  Created by GREGORY PETROV on 03/12/2020.
//

import Foundation


struct Comment: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case postId
        case name
        case email = "email"
        case body
    }
    
    let id: Int
    let postId : Int
    let name: String
    let email: String
    let body: String
    
    init(id:Int? ,postId:Int?, name:String?, email:String?, body:String?) {
        self.id = id ?? 0
        self.postId = postId ?? 0
        self.name = name ?? ""
        self.email = email ?? ""
        self.body = body ?? ""        
    }
}
