//
//  KeychainManager.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/13.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

final class KeychainManager {
    
    //  シングルトン
    private init() {}
    static let sharedKeychain = KeychainManager()
    
    //  インスタンスを保持
    let keychain: Keychain = {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier")
            as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }()
    
    func set(token: String) {
        try? keychain.set(token, key: "token")  //  keychainで値を保存
    }
    
    func get() -> String? {
        try? keychain.get("token")
    }
    
    func remove() {
        try? keychain.remove("token")
    }
}


