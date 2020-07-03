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
    
    private let signupViewModel = SignupViewModel()
    
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
        dismiss(animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        //  nilチェック
        guard let mail = mailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirmation = passwordConfirmationTextField.text else { return }
        
        signupViewModel.signup(inputValue: (mail, password, passwordConfirmation), successAction: {
            let books: MainTabController = MainTabController()
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            window?.rootViewController = books
        }){ error in
            self.showAlert(message: error.message)
        }
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
        view.endEditing(true)
    }
}
