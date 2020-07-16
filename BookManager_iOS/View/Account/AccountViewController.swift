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
        accountViewModel.logout(
            successAction: { [unowned self] in
                //  ダイアログ設定
                self.showSelectiveAlert()},
            errorAction: { [unowned self] error in
                self.showAlert(message: error) }
        )
    }
}
