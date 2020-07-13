//
//  Request.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

enum URLSessionRequest {
    
    static let BaseURL: String = "http://54.250.239.8/"
    
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
    
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
        case .bookList(let bookValue):
            //  https://baseURL?name=value
            let query = [
                URLQueryItem(name: "page", value: String(bookValue.page)),
                URLQueryItem(name: "limit", value: String(bookValue.limit))
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
            return "sign_up"
            
        case .bookList, .addBook:
            return "books"
            
        case .editBook(let params):
            return "books/\(params.id ?? 0)"
            
        case .account:
            return "logout"
        }
    }
    
    var header: String? {
        switch self {
        case .login, .signup:
            return nil
            
        case .bookList, .addBook, .editBook, .account:
            do {
                return try keychain.get("token")
            } catch {
                return nil
            }
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let userInputValue), .signup(let userInputValue):
            let body = JSONEncoder().encode(value: userInputValue)
            return body
            
        case .addBook(let bookInputValue), .editBook(let bookInputValue):
            let body = JSONEncoder().encode(value: bookInputValue)
            return body
            
        default:
            break
        }
        return nil
    }
    
    static func createRequest(type: URLSessionRequest) -> URLRequest? {
        var components = URLComponents(string: "\(BaseURL)\(type.path)")
        components?.queryItems = type.query
        
        let url = components?.url
        var request = URLRequest(url: url!)
        request.httpMethod = type.method
        request.httpBody = type.body
        
        //  ヘッダーにcontent-typeを設定(JSONを送るのでapplication/json)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(type.header, forHTTPHeaderField: "access_token")
        return request
    }
}
