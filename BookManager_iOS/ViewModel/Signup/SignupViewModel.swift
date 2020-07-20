//
//  SignupViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class SignupViewModel {
    
    typealias request = Request.Signup
    
    private struct Const {
        static let minimumLengthOfCharactors: Int = 6
    }
    
    typealias inputValue = (
        mail: String,
        password: String,
        passwordConfirmation: String
    )
    
    private func validateSignup(mail: String,
                                password: String,
                                passwordConfirmation: String,
                                failerHandler: (String) -> Void) -> Bool {
        
        var errors: [ValidationError]
        var messages = [String]()
        var message: String
        
        let validationResults = [EmailValidator().validate(mail),
                                 PasswordValidator().validate(password),
                                 PasswordComrimationValidator(password: password).validate(passwordConfirmation)]
        
        let filteredValidationResults = validationResults.filter({ !$0.isValid })
        
        if filteredValidationResults.count > 0 {
            
            errors = filteredValidationResults.compactMap { $0.error }
            errors.forEach { messages.append($0.description ?? "") }
            message = messages.joined(separator: "\n")
            failerHandler(message)
        } else { return false }
        
        return true
    }
    
    func signup(
        inputValue: inputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if validateSignup(mail: inputValue.mail,
                          password: inputValue.password,
                          passwordConfirmation: inputValue.passwordConfirmation,
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
                errorAction(R.string.localizable.notUniqueMail())
            }
        }
    }
}
