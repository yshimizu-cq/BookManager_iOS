//
//  SignupViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation
import KeychainAccess

final class SignupViewModel {
    
    private struct Const {
        static let minimumLengthOfCharactors: Int = 6
    }
    
    var keychain: Keychain {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return Keychain(service: "") }
        return Keychain(service: identifier)
    }
    
    typealias inputValue = (mail: String, password: String, passwordConfirmation: String)
    
    enum SignupError: Error {
        case empty
        case count
        case mismatch
        case notUniqueMail
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
            case .count:
                return R.string.localizable.countCharacters()
            case .mismatch:
                return R.string.localizable.mismatch()
            case .notUniqueMail:
                return R.string.localizable.notUniqueMail()
            }
        }
    }
    
    private func isValid(mail: String, password: String, passwordConfirmation: String) -> SignupError? {
        //  未入力チェック
        if mail.isEmpty || password.isEmpty || passwordConfirmation.isEmpty {
            return .empty
        }
        //  文字数チェック
        if mail.count < Const.minimumLengthOfCharactors || password.count < Const.minimumLengthOfCharactors
            || passwordConfirmation.count < Const.minimumLengthOfCharactors {
            return .count
        }
        //  パスワード一致チェック
        if password != passwordConfirmation {
            return .mismatch
        }
        return nil
    }
    
    func signup(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping (SignupError) -> Void) {
        if let error = isValid(mail: inputValue.mail, password: inputValue.password, passwordConfirmation: inputValue.passwordConfirmation) {
            errorAction(error)
            return
        }
        
        let inputValue = UserRequest(email: inputValue.mail, password: inputValue.password)
        APIClient.sendRequest(type: .signup(inputValue), entity: UserResponse.self) { (result) in
            switch result {
            case .success(let response):
                let token = response.result.token
                try? self.keychain.set(token, key: "token")  //  keychainで値を保存
                successAction()
            case .failure:
                errorAction(.notUniqueMail)
            }
        }
    }
}
