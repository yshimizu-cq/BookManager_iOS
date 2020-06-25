//
//  ValidatorProtocol.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/25.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

// 文字列のValidationに関する責務
protocol Validator {
    func validate(_ value: String) -> ValidationResult
}

// 文字列のValidationに関する責務。複数のValidatorを保持する
// validatorsに格納されている順にValidationをかけていき、
// 該当したエラーを返却する。
protocol CompositeValidator: Validator {
    var validators: [Validator] { get }
    func validate(_ value: String) -> ValidationResult
}

 extension CompositeValidator {
    
    func validate(_ value: String) -> [ValidationResult] {
        return validators.map { $0.validate(value) }
    }

     func validate(_ value: String) -> ValidationResult {
        let results: [ValidationResult] = validate(value)
        
        let errors = results.filter { result -> Bool in
            switch result {
            case .valid: return false
            case .invalid: return true
            }
        }
        return errors.first ?? .valid
    }
    
}

// Validation結果
//
// - valid: 有効
// - invalid: 無効
enum ValidationResult {
    case valid
    case invalid(ValidationError)
}

// Validation結果のエラーに使用
// LocalizedErrorを使用することで .localizedDescriptionでエラーメッセージを表示可能
//protocol ValidationErrorProtocol: LocalizedError { }


enum ValidationError: Error {

    case empty
    case length(min: Int, max: Int)
    case nameFormat
    
    var errorDescription: String? {
        switch self {
        case .empty(let textFieldName): return "\(textFieldName)を入力してください"
        case .length(let min, let max): return "\(min)文字以上\(max)文字以下で入力してください。"
        case .isNotDate: return ""

        }
    }
}
