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

    //  メールアドレス入力用
    @IBOutlet weak var mailTextField: UITextField!
    
    //  パスワード入力用
    @IBOutlet weak var passwordTextField: UITextField!
    
    //  画面が読み込まれた際に実行すること
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //  ログインボタンをタップした時の処理
    @IBAction func loginButtonTapped(_ sender: UIButton) {
    }
    
    //  新規アカウント作成ボタンをタップした時の処理
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
    

}

