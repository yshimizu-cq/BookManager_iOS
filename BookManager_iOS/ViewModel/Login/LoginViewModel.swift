//
//  LoginViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/02.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

final class LoginViewModel {
    
    private struct Const {
        static let minimumLengthOfCharactors: Int = 6
    }
    
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
        
    //  typealias => あとで型変更できる
    typealias inputValue = (mail: String, password: String)
    
    enum LoginError: Error {
        case empty
        case count
        case notUserFound
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
            case .count:
                return R.string.localizable.countCharacters()
            case .notUserFound:
                return R.string.localizable.notUserFound()
            }
        }
    }
    
    private func isValid(mail: String, password: String) -> LoginError? {
        //  未入力チェック
        if mail.isEmpty || password.isEmpty {
            return .empty
        }
        //  文字数チェック
        if mail.count < Const.minimumLengthOfCharactors || password.count < Const.minimumLengthOfCharactors {
            return .count
        }
        return nil
    }
    
    //  ViewControllerから呼ばれる
    func login(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping (LoginError) -> Void) {
        
        if let error = isValid(mail: inputValue.mail, password: inputValue.password) {
            errorAction(error)
            return
        }
        
        let inputValue = UserRequest(email: inputValue.mail, password: inputValue.password)
        APIClient.sendRequest(type: .login(inputValue), entity: UserResponse.self) { (result) in
            switch result {
            case .success(let response):
                let token = response.result.token
                try? self.keychain.set(token, key: "token")  //  keychainで値を保存
                successAction()
            case .failure:
                errorAction(.notUserFound)
            }
        }
    }
}
