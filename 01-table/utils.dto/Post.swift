//
//  Post.swift
//  KivaLoan
//
//  Created by GREGORY PETROV on 25/11/2020.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import Foundation



struct Post: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case userIdentifier = "userId"
    }
    
    let id: Int
    let title: String
    let body: String
    let userIdentifier: Int
    
    init(id:Int? ,userId:Int?, title:String?, body:String?) {
        self.id = id ?? 0
        self.userIdentifier = userId ?? 0
        self.title = title ?? ""
        self.body = body ?? ""
        
    }
}



