//
//  AccountViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.account()
        
    }
    
    @IBAction func didLogoutButtonTapped(_ sender: UIButton) {
        //  ダイアログ設定
        let logoutDialog = UIAlertController(title: R.string.localizable.logout(), message: R.string.localizable.okay(), preferredStyle: .alert)
        logoutDialog.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .cancel))
        logoutDialog.addAction(UIAlertAction(title: R.string.localizable.okayQuestion(), style: .default,
                                             handler: { _ in
                                                //  rootにlogin storyboardを設定して遷移
                                                let storyboard = R.storyboard.login().instantiateInitialViewController()
                                                guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
                                                window.rootViewController = storyboard
        }))
        self.present(logoutDialog, animated: true)
    }
}
