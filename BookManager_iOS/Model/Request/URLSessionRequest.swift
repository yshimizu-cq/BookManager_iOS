//
//  Request.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//
import Foundation

protocol APIRequestProtocol {
    associatedtype Responses: Decodable
    associatedtype Parameters: Encodable
    var path: String { get }    //  { get } =>読み込み専用
    var method: String { get }
    var headers: String? { get }
    var params: Parameters? { get set }   //  { get set } =>読み込み専用・代入が可能なプロパティ
}

struct Request {
    struct Login: APIRequestProtocol {
        typealias Responses = UserResponse
        typealias Parameters = UserRequest
        
        let path = "/login"
        let method = "POST"
        let headers: String? = nil
        var params: Parameters?
    }
    
    struct Signup: APIRequestProtocol {
        typealias Responses = UserResponse
        typealias Parameters = UserRequest
        
        let path = "/sign_up"
        let method = "POST"
        let headers: String? = nil
        var params: Parameters?
    }
    
    struct BookList: APIRequestProtocol {
        typealias Responses = BookListResponse
        typealias Parameters = BookListRequest
        
        let path = "/books"
        let method = "GET"
        let headers = KeychainManager.get()
        var params: Parameters?
    }
    
    struct Logout: APIRequestProtocol {
        typealias Responses = LogoutResponse
        typealias Parameters = UserRequest
        
        let path = "/logout"
        let method = "DELETE"
        let headers = KeychainManager.get()
        var params: Parameters?
    }
    
    struct EditBook: APIRequestProtocol {
        
        typealias Responses = BookResponse
        typealias Parameters = BookRequest
        
        let id: Int
        var path: String {
            return "/books/\(id.description)"
        }
        let method = "PATCH"
        let headers = KeychainManager.get()
        var params: Parameters?
    }
    
    struct AddBook: APIRequestProtocol {
        typealias Responses = BookResponse
        typealias Parameters = BookRequest
        
        let path = "/books"
        let method = "POST"
        let headers = KeychainManager.get()
        var params: Parameters?
    }
}

//  Mirror
extension Encodable {
    func makeQueryItems() -> [URLQueryItem] {
        return Mirror(reflecting: self).children.compactMap { child -> URLQueryItem in
            return URLQueryItem(name: child.label ?? "",
                                value: child.value as? String ?? "")
        }
    }
}
