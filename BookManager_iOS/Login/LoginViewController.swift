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
        let minimumLengthOfCharactors = 6
        
        guard let mail = mailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        //　未入力チェック
        guard !mail.isEmpty, !password.isEmpty else {
            showAlert(message: R.string.localizable.blank())
            return
        }
        
        // 文字数チェック
        guard mail.count >= minimumLengthOfCharactors, password.count >= minimumLengthOfCharactors else {
            showAlert(message: R.string.localizable.countCharacters())
            return
        }
        
        let books: MainTabController = MainTabController()
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = books
    }
    
    @IBAction func didSignupButtonTapped(_ sender: UIButton) {
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.signup()
        //  遷移先ViewControllerのインスタンス取得
        guard let signupView = storyboard.instantiateInitialViewController() as? SignupViewController else { return }
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
