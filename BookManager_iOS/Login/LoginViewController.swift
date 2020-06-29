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
    @IBOutlet weak var passwordTextField: UITextField!
    
    //  画面ロード後に実行すること
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 入力された文字を非表示モードにする.
        passwordTextField.isSecureTextEntry = true
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let minimumLengthOfCharactors = 6
        
        guard let mail = mailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        //　未入力チェック
        guard !mail.isEmpty, !password.isEmpty else {
            alertMessage(message: "未入力項目があります")
            return
        }
        
        // 文字数チェック
        guard mail.count >= minimumLengthOfCharactors, password.count >= minimumLengthOfCharactors else {
            alertMessage(message: "メールアドレスとパスワードは6文字以上で設定してください")
            return
        }
        
        let books: MainTabController = MainTabController()
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = books
        
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.signup()
        //  遷移先ViewControllerのインスタンス取得
        guard let signupView = storyboard.instantiateInitialViewController() as? SignupViewController else { return }
        //  画面遷移
        navigationController?.pushViewController(signupView, animated: true)
        
    }
    
    //  returnでキーボードを閉じる
    @IBAction func mailTextField(_ sender: UITextField) {
        mailTextField.text = sender.text
    }
    //  returnでキーボードを閉じる
    @IBAction func passwordTextField(_ sender: UITextField) {
        passwordTextField.text = sender.text
    }
    
    //  画面タップでキーボードを閉じる
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

