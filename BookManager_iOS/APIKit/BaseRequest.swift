//
//  BaseRequest.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/29.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

//  参考("https://qiita.com/sgr-ksmt/items/e822a379d41462e05e0d")

import Foundation
import APIKit

//  Requestに準拠したBaseRequestの定義
protocol BaseRequest: Request {

}

extension BaseRequest {
    var baseURL: URL {
        return URL(string: "https://api.base.com")!
    }
}

extension BaseRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }
    
    // response(from: ,URLResponse:)に渡ってくるobjectはData、それをデコード処理
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
