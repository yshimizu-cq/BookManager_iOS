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
    
    private func extractSignupValidationErrors(
        mail: String,
        password: String,
        passwordConfirmation: String) -> [ValidationError]? {
        
        let validationResults = [EmailValidator().validate(mail),
                                 PasswordValidator().validate(password),
                                 PasswordComrimationValidator(password: password).validate(passwordConfirmation)]
        
        if validationResults.filter({ !$0.isValid }).count > 0 {
            return validationResults.filter({ !$0.isValid }).compactMap { $0.error }
        } else { return nil }
    }
    
    private func generateErrorMessage(by errors: [ValidationError]) -> String {
        var messages = [String]()
        errors.forEach { messages.append($0.description!) }
        return messages.joined(separator: "\n")
    }
    
    func signup(
        inputValue: inputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if let error: [ValidationError] = extractSignupValidationErrors(
            mail: inputValue.mail,
            password: inputValue.password,
            passwordConfirmation: inputValue.passwordConfirmation) {
            
            errorAction(generateErrorMessage(by: error))
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
