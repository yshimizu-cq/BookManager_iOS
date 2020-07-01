//
//  SignupViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/19.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

//  サインアップ画面
final class SignupViewController: UIViewController {
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var passwordConfirmationTextField: UITextField! {
        didSet {
            passwordConfirmationTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func returnButtonTapped(_ sender: UIBarButtonItem) {
        //  自身を破棄して遷移元の画面に戻る
        self.dismiss(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let minimumLengthOfCharactors = 6
        
        //  nilチェック
        guard let mail = mailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirmation = passwordConfirmationTextField.text,
            //　未入力チェック
            !mail.isEmpty, !password.isEmpty, !passwordConfirmation.isEmpty else {
                showAlert(message: R.string.localizable.blank())
                return
        }
        
        // 文字数チェック
        guard mail.count >= minimumLengthOfCharactors, password.count >= minimumLengthOfCharactors else {
            showAlert(message: R.string.localizable.countCharacters())
            return
        }
        
        // パスワード一致チェック
        guard password == passwordConfirmation else {
            showAlert(message: R.string.localizable.notMatch())
            return
        }
        
        let books: MainTabController = MainTabController()
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = books
    }
    
    @IBAction func didTapMailReturn(_ sender: UITextField) {
        mailTextField.text = sender.text
    }
    
    @IBAction func didTapPasswordReturn(_ sender: UITextField) {
        passwordTextField.text = sender.text
    }
    
    @IBAction func didTapPasswordConfirmationReturn(_ sender: UITextField) {
        passwordConfirmationTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
