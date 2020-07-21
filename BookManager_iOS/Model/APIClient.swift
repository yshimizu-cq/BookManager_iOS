//
//  APIClient.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

struct APIClient {
    static func sendRequest<T: APIRequestProtocol>(
        from type: T,
        completionAction: @escaping (Result<T.Responses, Error>) -> Void) {
        
        let BaseURL: String = "http://54.250.239.8"
        
        func createRequest() -> URLRequest? {
            guard var components = URLComponents(string: "\(BaseURL)\(type.path)") else { return  nil}
            
            if type.method == "GET" {
                let queryItems = type.params?.makeQueryItems()
                components.queryItems = queryItems
            }
            
            guard let url = components.url else { return nil}
            var request = URLRequest(url: url)
            request.httpMethod = type.method
            
            if type.method != "GET" {
                let httpBody = JSONEncoder().encode(value: type.params)
                request.httpBody = httpBody
            }
            
            //  ヘッダーにcontent-typeを設定(JSONを送るのでapplication/json)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(type.headers, forHTTPHeaderField: "access_token")
            return request
        }
        
        guard let request = createRequest() else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completionAction(.failure(error))
            }
            
            guard let data = data else {
                print(R.string.localizable.noData())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let json = try jsonDecoder.decode(T.Responses.self, from: data)
                DispatchQueue.main.sync {
                    completionAction(.success(json))
                }
            } catch {
                DispatchQueue.main.sync {
                    completionAction(.failure(error))
                }
            }
        }
        task.resume()
    }
}
