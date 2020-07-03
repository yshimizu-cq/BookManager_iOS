//
//  Request.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/02.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

//import Foundation
//
//class LoginURLSession {
//
//    // 認証情報
//    let mail = "mail"
//    let password = "password"
//    // リクエスト準備
//    let session = URLSession.shared
//    guard let url = URL(string: "https://sample-api.com") else { return }
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    guard let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8) else { return }
//    let credential = credentialData.base64EncodedString(options: [])
//    let basicData = "Basic \(credential)"
//    request.setValue(basicData, forHTTPHeaderField: "Authorization")
//    // リクエスト実行
//    session.dataTask(with: request) { data, urlresponse, error in
//      // レスポンス処理
//    }.resume()
//}
