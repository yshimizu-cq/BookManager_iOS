//
//  Request.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

enum URLSessionRequest {
    case login(UserRequest)
    case signup(UserRequest)
    case bookList(BookListRequest)
    case addBook(BookRequest)
    case editBook(BookRequest)
    case account
    
    var method: String {
        switch self {
        case .bookList:
            return "GET"
        case .login, .signup, .addBook:
            return "POST"
        case .editBook:
            return "PATCH"
        case .account:
            return "DELETE"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .bookList(let bookParams):
            //  https://baseURL?name=value
            let query = [
                URLQueryItem(name: "name", value: String(bookParams.limit)),
                URLQueryItem(name: "name", value: String(bookParams.page))
            ]
            return query
        default:
            break
        }
        return []
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .signup:
            return "signup"
        case .bookList, .addBook:
            return "books"
        case .editBook(let params):
            return "books/\(params.id)"
        case .account:
            return "account"
        }
    }
    
    var header: String? {
        switch self {
        case .login, .signup:
            return nil
        case .bookList, .addBook, .editBook, .account:
            return UserDefaultsUtil.token
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let userParams), .signup(let userParams):
            let body = JSONEncoder().encode(value: userParams)
            return body
        case .addBook(let bookParams), .editBook(let bookParams):
            let body = JSONEncoder().encode(value: bookParams)
        default:
            break
        }
        return nil
    }
    
    static func createRequest(type: URLSessionRequest) -> URLRequest? {
        var components = URLComponents(string: "http://54.250.239.8/\(type.path)")
        components?.queryItems = type.query
        let url = components?.url
        var request = URLRequest(url: url!)
        request.httpMethod = type.method
        request.httpBody = type.body
        //  ヘッダーにcontent-typeを設定(JSONを送るのでapplication/json)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue(type.header, forHTTPHeaderField: "Authorization")
        return request
    }
}
