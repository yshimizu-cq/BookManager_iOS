//
//  BookListResponse.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

struct BookListResponse: Decodable {
    var result: [Book]
}
