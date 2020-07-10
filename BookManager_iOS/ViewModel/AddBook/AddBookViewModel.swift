//
//  AddBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class AddBookViewModel {
    
    typealias inputValue = (title: String, image: String?, price: Int?, date: String?)
        
    enum AddBookError: Error {
        case empty
        case failToAddBook
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
                
            case .failToAddBook:
                return R.string.localizable.faliToAddBook()
            }
        }
    }
    
    private func isValid(title: String, price: Int, purchaseDate: String) -> AddBookError? {
        //  未入力チェック
        if title.isEmpty || price.description.isEmpty || purchaseDate.isEmpty {
            return .empty
        }
        return nil
    }
    
    func addBook(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping (AddBookError) -> Void) {
        if let error = isValid(title: inputValue.title, price: inputValue.price ?? 0, purchaseDate: inputValue.date ?? String(2020-07-01)) {
            errorAction(error)
            return
        }
        
        let inputValue = BookRequest(name: inputValue.title, image: inputValue.image, price: inputValue.price, purchaseDate: inputValue.date)
        
        APIClient.sendRequest(type: .addBook(inputValue), entity: BookResponse.self) { (result) in
            switch result {
            case .success:
                successAction()
            case .failure:
                errorAction(.failToAddBook)
            }
        }
    }
}
