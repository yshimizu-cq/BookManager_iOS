//
//  AccountViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "アカウント"
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        
        let storyboard: UIStoryboard = R.storyboard.login()
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.rootViewController = storyboard.instantiateInitialViewController()
        
    }
    
}
