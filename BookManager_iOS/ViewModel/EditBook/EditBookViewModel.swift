//
//  EditBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class EditBookViewModel {
    
    typealias inputValue = (id: Int?, title: String, image: String?, price: Int?, date: String?)
    
    var selectedBook: Book?
    
    func extracteditBookValidationErrors(title: String) -> [ValidationError]? {
        let validationResults = [BookNameValidator().validate(title)]
        
        if validationResults.filter({ !$0.isValid }).count > 0 {
            return validationResults.filter({ !$0.isValid }).compactMap { $0.error }
        } else { return nil }
    }
    
    func generateErrorMessage(by errors: [ValidationError]) -> String {
        var messages = [String]()
        errors.forEach { messages.append($0.description!) }
        return messages.joined(separator: "\n")
    }
    
    func editBook(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping (String) -> Void) {
        if let error: [ValidationError] = extracteditBookValidationErrors(title: inputValue.title) {
            errorAction(generateErrorMessage(by: error))
            return
        }
        
        let inputValue = BookRequest(id: inputValue.id, name: inputValue.title, image: inputValue.image, price: inputValue.price, purchaseDate: inputValue.date)
        APIClient.sendRequest(type: .editBook(inputValue), entity: BookResponse.self) { (result) in
            switch result {
            case .success:
                successAction()
                
            case .failure:
                errorAction(R.string.localizable.faliToEditBook())
            }
        }
    }
}

