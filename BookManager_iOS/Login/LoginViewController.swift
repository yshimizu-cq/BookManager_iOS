//
//  ViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/18.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit


//  ログイン画面
class LoginViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {

        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.signup()
        //  遷移先ViewControllerのインスタンス取得
        guard let signupView = storyboard.instantiateInitialViewController() as? SignupViewController else { return }
        // 画面遷移
        navigationController?.pushViewController(signupView, animated: true)
        
    }
    

}

