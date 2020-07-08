//
//  EditBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class EditBookViewModel {
    
    typealias inputValue = (id: Int?, image: String?, title: String, price: Int?, date: String?)
    
    var selectedBook: Book?
    
    enum EditBookError: Error {
        case empty
        case failToEditBook
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
            case .failToEditBook:
                return R.string.localizable.faliToEditBook()
            }
        }
    }
    
    private func isValid(title: String, price: Int, purchaseDate: String) -> EditBookError? {
        //  未入力チェック
        if title.isEmpty || price.description.isEmpty || purchaseDate.isEmpty {
            return .empty
        }
        return nil
    }
    
    func editBook(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping(EditBookError) -> Void) {
        if let error = isValid(title: inputValue.title, price: inputValue.price ?? 0, purchaseDate: inputValue.date ?? String(2020-07-01)) {
            errorAction(error)
            return
        }
        
        let inputValue = BookRequest(id: inputValue.id, name: inputValue.title, image: inputValue.image, price: inputValue.price, purchaseDate: inputValue.date)
        APIClient.sendRequest(type: .editBook(inputValue), entity: BookResponse.self) { (result) in
            switch result {
            case .success:
                UserDefaultsUtil.set(value: inputValue.id ?? 0, forKey: "book")
                successAction()
            case .failure:
                errorAction(.failToEditBook)
            }
        }
    }
}

