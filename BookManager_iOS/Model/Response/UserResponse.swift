//
//  UserResponse.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.

import Foundation

struct UserResponse: Decodable {
    var result: User
    
    struct User: Decodable {
        var id: Int
        var email: String
        var token: String
    }
}

struct AccountResponse: Decodable {
    var status: Int
}
