//
//  KeychainManager.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/13.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainManager {
    static var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier")
            as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
    
    static func set(token: String) {
        try? keychain.set(token, key: "token")  //  keychainで値を保存
    }
    
    static func get() -> String? {
        try? keychain.get("token")
    }
    
    static func remove() {
        try? keychain.remove("token")
    }
}
