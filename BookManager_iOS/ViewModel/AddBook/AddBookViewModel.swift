//
//  AddBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class AddBookViewModel {
    
    typealias BookRequest = Request.AddBook
    
    typealias InputValue = (
        title: String,
        image: String?,
        price: Int?,
        date: String?
    )
    
    private func validateAdd(title: String,
                             failureHandler: (String) -> Void) -> Bool {
        
        var errors: [ValidationError]
        var messages = [String]()
        var message: String
        
        let validationResults = [BookNameValidator().validate(title)]
        
        let filteredValidationResults = validationResults.filter({ !$0.isValid })
        
        if filteredValidationResults.count > 0 {
            
            errors = filteredValidationResults.compactMap { $0.error }
            errors.forEach { messages.append($0.description ?? "") }
            message = messages.joined(separator: "\n")
            failureHandler(message)
        } else { return false }
        
        return true
    }
    
    func addBook(
        inputValue: InputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if validateAdd(title: inputValue.title, failureHandler: errorAction) {
            return
        }
        
        let params = BookRequest.Parameters(
            name: inputValue.title,
            image: inputValue.image,
            price: inputValue.price,
            purchaseDate: inputValue.date
        )
        
        APIClient.sendRequest(from: BookRequest(params: params)) { (result) in
            switch result {
            case .success:
                successAction()
            case .failure:
                errorAction(R.string.localizable.failToAddBook())
            }
        }
    }
}
