//
//  AppDelegate.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/18.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // NavigationControllerの設定
        let loginView: LoginViewController = LoginViewController()
        navigationController = UINavigationController(rootViewController: loginView)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
        
    }

}

