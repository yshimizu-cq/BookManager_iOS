//
//  EditBookViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/03.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class EditBookViewModel {
    
    typealias inputValue = (title: String, price: Int, date: String)
    
    enum EditBookError: Error {
        case empty
        
        var message: String {
            switch self {
            case .empty:
                return R.string.localizable.blank()
            }
        }
    }
    
    private func isValid(title: String, price: Int, date: String) -> EditBookError? {
        //  未入力チェック
        if title.isEmpty || price.description.isEmpty || date.isEmpty {
            return .empty
        }
        return nil
    }
    
    func editBook(inputValue: inputValue, successAction: @escaping () -> Void, errorAction: @escaping(EditBookError) -> Void) {
        if let error = isValid(title: inputValue.title, price: inputValue.price, date: inputValue.date) {
            errorAction(error)
            return
        }
    }
}
