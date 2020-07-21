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
    
    //  LoginViewCotnrollerがインスタンス化されたときにLoginViewModelもインスタンス化される
    private let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var mailTextField: UITextField!
    
    //  IBでプロパティを定義する場合、didSetを使うことで各部品毎に見やすくなる
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            // 入力された文字を非表示モードにする.
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBAction func didLoginButtonTapped(_ sender: UIButton) {
        guard let mail = mailTextField.text,
            let password = passwordTextField.text else { return }
        
        loginViewModel.login(
            inputValue: (mail, password),
            successAction: {
                let books: MainTabController = MainTabController()
                let window = UIApplication.shared.windows.first { $0.isKeyWindow }
                window?.rootViewController = books },
            errorAction: { [unowned self] error in
                self.showAlert(message: error) }
        )
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
        view.endEditing(true)
    }
}
