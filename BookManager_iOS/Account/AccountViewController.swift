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
        self.parent?.navigationItem.title = "アカウント"
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.login()
        //  遷移先ViewControllerのインスタンス取得
        guard let loginView = storyboard.instantiateInitialViewController() as? LoginViewController else { return }
        //  画面遷移
//        self.present(loginView, animated: true, completion: nil)
        navigationController?.pushViewController(loginView, animated: true)
    }
    
}
