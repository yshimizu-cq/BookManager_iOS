//
//  UserDefaultsUtil.swift
//  
//
//  Created by 清水雄大 on 2020/07/06.
//

import Foundation
struct UserDefaultsUtil {
    
    static var isFirstLaunch: Bool {
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
        return isFirstLaunch
    }
    
    static func setLaunchFlag(value: Any) {
        UserDefaults.standard.set(value, forKey: "isFirstLaunch")
    }
    
    static func register(defaults: [String: Any]) {
        UserDefaults.standard.register(defaults: defaults)
    }
}
