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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.isSecureTextEntry = true
        passwordConfirmationTextField.isSecureTextEntry = true
        
    }
    
    @IBAction func returnButtonTapped(_ sender: UIBarButtonItem) {
        //  自身を破棄して遷移元の画面に戻る
        self.dismiss(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let minimumLengthOfCharactors = 6
        
        guard let mail = mailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirmation = passwordConfirmationTextField.text else {
                return
        }
        //　未入力チェック
        guard !mail.isEmpty, !password.isEmpty, !passwordConfirmation.isEmpty else {
            alertMessage(message: "未入力項目があります")
            return
        }
        
        // 文字数チェック
        guard mail.count >= minimumLengthOfCharactors, password.count >= minimumLengthOfCharactors else {
            alertMessage(message: "メールアドレスとパスワードは6文字以上で設定してください")
            return
        }
        
        // パスワード一致チェック
        guard password == passwordConfirmation else {
            alertMessage(message: "パスワードが一致していません")
            return
        }
        
        let books: MainTabController = MainTabController()
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = books
    }
    
    @IBAction func mailTextField(_ sender: UITextField) {
        mailTextField.text = sender.text
    }
    
    @IBAction func passwordTextField(_ sender: UITextField) {
        passwordTextField.text = sender.text
    }
    
    @IBAction func passwordConfirmationTextField(_ sender: UITextField) {
        passwordConfirmationTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // アラート表示
    private func alertMessage(message: String) {
        let alert = UIAlertController(title: "入力エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

