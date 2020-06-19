//
//  SignupViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/19.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

//  サインアップ画面
class SignupViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func returnButtonTapped(_ sender: UIBarButtonItem) {
        //  自身を破棄して遷移元の画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signupButtonTapped(_ sender: UIButton) {
    }
}

