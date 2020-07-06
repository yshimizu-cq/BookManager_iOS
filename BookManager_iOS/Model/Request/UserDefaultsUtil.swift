//
//  UserDefaultsUtil.swift
//  
//
//  Created by 清水雄大 on 2020/07/06.
//

import Foundation
struct UserDefaultsUtil {
    
    static var token = UserDefaults.standard.string(forKey: "token")
    
    static var isFirstLaunch: Bool {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        return isFirstLaunch
    }
    
    static func set(value: Any, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    
    static func register(defaults : [String : Any]) {
        UserDefaults.standard.register(defaults: defaults)
    }
    
    static func removeToken() {
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
}
