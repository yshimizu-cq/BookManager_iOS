//
//  AccountViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class AccountViewController: UIViewController {
    
    private let accountViewModel = AccountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.account()
    }
    
    @IBAction func didLogoutButtonTapped(_ sender: UIButton) {
        
        let handler: ((UIAlertAction) -> Void)? = { _ in
            let storyboard = R.storyboard.login().instantiateInitialViewController()
            
            guard let window =
                UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
            
            window.rootViewController = storyboard
        }
        //  rootにlogin storyboardを設定して遷移
        accountViewModel.logout(
            successAction: { [unowned self] in
                //  ダイアログ設定
                self.showSelectiveAlert(handler: handler)},
            errorAction: { [unowned self] error in
                self.showAlert(message: error) }
        )
    }
}
