//
//  BookListViewModel.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/07.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import Foundation

final class BookListViewModel {
    
    typealias request = Request.BookList
    
    private var currentPage = 1
    
    private(set) var books: [Book] = []
    
    func setBookList(initial: Bool, successAction: @escaping () -> Void, errorAction: @escaping(Error) -> Void) {
        
        if initial {
            currentPage = 1
        } else {
            currentPage += 1
        }
        
        let params = request.Parameters(page: currentPage, limit: 20)
        
        APIClient.sendRequest(from: request(params: params)) { (result) in
            switch result {
            case .success(let response):
                self.books.append(contentsOf: response.result)  //  resultをハッシュ形式でbooksに追加
                successAction()
                
            case .failure(let error):
                errorAction(error)
            }
        }
    }
    
    func update(books: [Book]) {
        self.books = books
    }
}

