//
//  ViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/18.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

//  ログイン画面
final class LoginViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    
    //  IBでプロパティを定義する場合、didSetを使うことで各部品毎に見やすくなる
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            // 入力された文字を非表示モードにする.
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func didLoginButtonTapped(_ sender: UIButton) {
        let Minimum_Length_Of_Charactors = 6
        
        //  nilチェック
        guard let mail = mailTextField.text,
            let password = passwordTextField.text,
            //　未入力チェック
            !mail.isEmpty, !password.isEmpty else {
                showAlert(message: R.string.localizable.blank())
                return
        }
        
        // 文字数チェック
        guard mail.count >= Minimum_Length_Of_Charactors, password.count >= Minimum_Length_Of_Charactors else {
            showAlert(message: R.string.localizable.countCharacters())
            return
        }
        
        let books: MainTabController = MainTabController()
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = books
    }
    
    @IBAction func didSignupButtonTapped(_ sender: UIButton) {
        //  Rswiftを使ってstoryboardのインスタンス取得して遷移先ViewControllerのインスタンス取得
        let signupView = R.storyboard.signup.instantiateInitialViewController()!
        //  画面遷移
        navigationController?.pushViewController(signupView, animated: true)
    }
    
    //  returnでキーボードを閉じる
    @IBAction func didTapMailReturn(_ sender: UITextField) {
        mailTextField.text = sender.text
    }
    
    //  returnでキーボードを閉じる
    @IBAction func didTapPasswordReturn(_ sender: UITextField) {
        passwordTextField.text = sender.text
    }
    
    //  画面タップでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
