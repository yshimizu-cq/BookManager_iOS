//
//  JSONEncoder.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

extension JSONEncoder {
    func encode<T: Encodable>(value: T) -> Data? {
        self.keyEncodingStrategy = .convertToSnakeCase
        let encodeValue = try? self.encode(value)
        return encodeValue
    }
}
