//
//  SignupViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class SignupViewModel {
    
    private struct Const {
        static let minimumLengthOfCharactors: Int = 6
    }
    
    typealias inputValue = (mail: String, password: String, passwordConfirmation: String)
    
    enum SignupError: Error {
        case empty
        case count
        case mismatch
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
            case .count:
                return R.string.localizable.countCharacters()
            case .mismatch:
                return R.string.localizable.notMatch()
            }
        }
    }
    
    private func isValid(mail: String, password: String, passwordConfirmation: String) -> SignupError? {
        //  未入力チェック
        if mail.isEmpty || password.isEmpty || passwordConfirmation.isEmpty {
            return .empty
        }
        //  文字数チェック
        if mail.count < Const.minimumLengthOfCharactors || password.count < Const.minimumLengthOfCharactors || passwordConfirmation.count < Const.minimumLengthOfCharactors {
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
    }
}
