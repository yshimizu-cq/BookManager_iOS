//
//  DecodableDataParser.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/29.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

//  参考("https://qiita.com/sgr-ksmt/items/e822a379d41462e05e0d")

import Foundation
import APIKit

final class DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    //  parse(data:)関数でそのままDataを返却するよう再定義
    func parse(data: Data) throws -> Any {
        return data
    }
}
