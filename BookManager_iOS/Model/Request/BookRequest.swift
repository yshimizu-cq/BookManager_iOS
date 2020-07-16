//
//  BookRequest.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

//  structは値型, 比較的単純なデータをカプセル化
struct BookRequest: Encodable {
    var id: Int
    var name: String
    var image: String?  //  nilを許容
    var price: Int?
    var purchaseDate: String?
}
