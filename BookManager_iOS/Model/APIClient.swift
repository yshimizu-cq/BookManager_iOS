//
//  APIClient.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/06.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

struct APIClient {
    
    static func sendRequest<T: Decodable>(type request: URLSessionRequest, entity: T.Type, completionAction: @escaping (Result<T, Error>) -> Void) -> Void {
        
        guard let request = URLSessionRequest.createRequest(type: request) else { return }
        
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
                let json = try jsonDecoder.decode(entity, from: data)
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


