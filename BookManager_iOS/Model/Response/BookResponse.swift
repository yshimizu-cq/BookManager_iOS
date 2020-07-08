//
//  BookResponse.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

struct BookResponse: Decodable {
    var result: Book
}

struct Book: Decodable {
    var id: Int?
    var name: String
    var image: String?
    var price: Int?
    var purchaseDate: String?
}
