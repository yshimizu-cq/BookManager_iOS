//
//  LoginViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/02.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    typealias UserRequest = Request.Login
    
    //  typealias => あとで型変更できる
    typealias InputValue = (mail: String, password: String)
    
    private func validateLogin(mail: String,
                               password: String,
                               failureHandler: (String) -> Void) -> Bool {
        
        var errors: [ValidationError]
        var messages = [String]()
        var message: String
        
        let validationResults = [EmailValidator().validate(mail),
                                 PasswordValidator().validate(password)]
        
        let filteredValidationResults = validationResults.filter({ !$0.isValid })
        
        if filteredValidationResults.count > 0 {
            
            errors = filteredValidationResults.compactMap { $0.error }
            errors.forEach { messages.append($0.description ?? "") }
            message = messages.joined(separator: "\n")
            failureHandler(message)
        } else { return false }
        
        return true
    }
    
    func login(
        inputValue: InputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if validateLogin(mail: inputValue.mail,
                         password: inputValue.password,
                         failureHandler: errorAction) {
            return
        }
        
        let params = UserRequest.Parameters(
            email: inputValue.mail,
            password: inputValue.password
        )
        
        APIClient.sendRequest(from: UserRequest(params: params)) { (result) in
            switch result {
            case .success(let response):
                let token = response.result.token
                KeychainManager.sharedKeychain.set(token: token)
                successAction()
                
            case .failure:
                errorAction(R.string.localizable.notUserFound())
            }
            
        }
    }
}
