//
//  EditBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class EditBookViewModel {
    
    typealias request = Request.EditBook
    
    typealias inputValue = (
        id: Int?,
        title: String,
        image: String?,
        price: Int?,
        date: String?
    )
    
    var selectedBook: Book?
    
    init(selectedBook: Book?) {
        self.selectedBook = selectedBook
    }
    
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
    
    func editBook(
        inputValue: inputValue,
        successAction: @escaping () -> Void,
        errorAction: @escaping (String) -> Void) {
        
        if let error: [ValidationError] = extracteditBookValidationErrors(
            title: inputValue.title) {
            
            errorAction(generateErrorMessage(by: error))
            return
        }
        
        let params = request.Parameters(
            id: inputValue.id,
            name: inputValue.title,
            image: inputValue.image,
            price: inputValue.price,
            purchaseDate: inputValue.date
        )
        
        APIClient.sendRequest(from: request(id: inputValue.id, params: params)) { (result) in
            switch result {
            case .success:
                successAction()
                
            case .failure:
                errorAction(R.string.localizable.faliToEditBook())
            }
        }
    }
}

