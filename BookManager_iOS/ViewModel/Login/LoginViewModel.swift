//
//  LoginViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/02.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    typealias request = Request.Login
    
    //  typealias => あとで型変更できる
    typealias inputValue = (mail: String, password: String)

    private func validateLogin(mail: String, password: String, failerHandler: (String) -> Void) -> Bool {
        
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
            failerHandler(message)
        } else { return false }
        
        return true
    }
    
    func login(
        inputValue: inputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if validateLogin(mail: inputValue.mail,
                         password: inputValue.password,
                         failerHandler: errorAction) {
            return
        }
        
        let params = request.Parameters(
            email: inputValue.mail,
            password: inputValue.password
        )
        
        APIClient.sendRequest(from: request(params: params)) { (result) in
            switch result {
            case .success(let response):
                let token = response.result.token
                KeychainManager.set(token: token)
                successAction()
                
            case .failure:
                errorAction(R.string.localizable.notUserFound())
            }
            
        }
    }
}
