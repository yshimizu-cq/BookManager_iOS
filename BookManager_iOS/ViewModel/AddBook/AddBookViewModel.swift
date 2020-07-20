//
//  AddBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class AddBookViewModel {
    
    typealias request = Request.AddBook
    
    typealias inputValue = (
        title: String,
        image: String?,
        price: Int?,
        date: String?
    )
    
    private func extractAddBookValidationErrors(title: String) -> [ValidationError]? {
        let validationResults = [BookNameValidator().validate(title)]
        
        let filteredValidationResults = validationResults.filter({ !$0.isValid })
        
        if filteredValidationResults.count > 0 {
            return filteredValidationResults.compactMap { $0.error }
        } else { return nil }
    }
    
    private func generateErrorMessage(by errors: [ValidationError]) -> String {
        var messages = [String]()
        errors.forEach { messages.append($0.description!) }
        return messages.joined(separator: "\n")
    }
    
    func addBook(
        inputValue: inputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if let error: [ValidationError] = extractAddBookValidationErrors(title: inputValue.title) {
            errorAction(generateErrorMessage(by: error))
            return
        }
        
        let params = request.Parameters(
            id: -1,
            name: inputValue.title,
            image: inputValue.image,
            price: inputValue.price,
            purchaseDate: inputValue.date
        )
        
        APIClient.sendRequest(from: request(params: params)) { (result) in
            switch result {
            case .success:
                successAction()
            case .failure:
                errorAction(R.string.localizable.failToAddBook())
            }
        }
    }
}
