//
//  ValidatorProtocol.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/09.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

//  参考URL: https://iganin.hatenablog.com/entry/2019/09/23/171221

private struct Const {
    static let minimumLengthOfCharactors: Int = 6
}

// Validation結果
// - valid: 有効
// - invalid: 無効
enum ValidationResult {
    case valid
    case invalid(ValidationError)
    
    var isValid: Bool {
        
        switch self {
        case .valid: return true
        case .invalid: return false
        }
    }
    
    var error: ValidationError? {
        
        guard case .invalid(let error) = self else { return  nil }
        return error
    }
}

// 文字列のValidationに関する責務
protocol ValidatorProtocol {
    func validate(_ value: String) -> ValidationResult
}

// 文字列のValidationに関する責務。複数のValidatorを保持する
// validatorsに格納されている順にValidationをかけていき
// 該当したエラーを返却する
protocol CompositeValidator: ValidatorProtocol {
    var validators: [ValidatorProtocol] { get }
    func validate(_ value: String) -> ValidationResult
}

extension CompositeValidator {
    
    func validateResultAllReasons(_ value: String) -> [ValidationResult] {
        return validators.map { $0.validate(value) }
    }
    
    func validate(_ value: String) -> ValidationResult {
        let results = validators.map { $0.validate(value)}
        
        return results.first(where: { result -> Bool in
            
            switch result {
            case .valid: return false
            case .invalid: return true
            }
        }) ?? .valid
    }
}

enum ValidationError: Error {
    
    case empty(formName: String)
    case count(formName: String, min: Int?)
    case unmatchConfirmPassword
    case notUserFound
    case notUniqueMail
    
    var description: String? {
        switch self {
        case .empty(let formName):
            return "\(formName)を入力してください"
            
        case .count(let formName, let min):
            var errorMessage = "\(formName)は"
            if min != nil { errorMessage += "\(Const.minimumLengthOfCharactors)文字以上" }
            return errorMessage + "で入力してください"
            
        case .unmatchConfirmPassword:
            return R.string.localizable.unmatch()
            
        case .notUserFound:
            return R.string.localizable.notUserFound()
            
        case .notUniqueMail:
            return R.string.localizable.notUniqueMail()
        }
    }
}

//  CompositeVaidatorStruct

//  メールアドレス検証用バリデーター
struct EmailValidator: CompositeValidator {
    var validators: [ValidatorProtocol] = [
        EmptyValidator(formName: "メールアドレス"),
        LengthValidator(formName: "メールアドレス", min: Const.minimumLengthOfCharactors)
    ]
}

//  パスワード検証用バリデーター
struct PasswordValidator: CompositeValidator {
    var validators: [ValidatorProtocol] = [
        EmptyValidator(formName: "パスワード"),
        LengthValidator(formName: "パスワード", min: Const.minimumLengthOfCharactors)
    ]
}

//  確認用パスワード検証用バリデーター
struct PasswordComrimationValidator: CompositeValidator {
    let password: String
    var validators: [ValidatorProtocol]
    
    init(password: String) {
        self.password = password
        validators = [EmptyValidator(formName: "パスワード確認"),
                      LengthValidator(formName: "パスワード確認", min: Const.minimumLengthOfCharactors),
                      MatchPasswordValidator(password: password)]
    }
}

//  ValidatorStruct

//  未入力検証用バリデーター
private struct EmptyValidator: ValidatorProtocol {
    let formName: String
    
    func validate(_ value: String) -> ValidationResult {
        return value.isEmpty ? .invalid(.empty(formName: formName)) : .valid
    }
}

//  文字長さ検証用バリデーター
private struct LengthValidator: ValidatorProtocol {
    let formName: String
    let min: Int
    
    func validate(_ value: String) -> ValidationResult {
        let isShortLength = min > value.count
        return isShortLength ? .invalid(.count(formName: formName, min: min)) : .valid
    }
}

//  パスワードと確認用パスワードの一致検証用バリデーター
private struct MatchPasswordValidator: ValidatorProtocol {
    let password: String
    
    func validate(_ value: String) -> ValidationResult {
        return password == value ? .valid : .invalid(.unmatchConfirmPassword)
    }
}
