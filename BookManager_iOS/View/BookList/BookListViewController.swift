//
//  BookListViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class BookListViewController: UIViewController {
    
    private var addBookButton: UIBarButtonItem!
    
    private let tableView = UITableView()
    
    private let bookListViewModel = BookListViewModel()
    
    private lazy var rightBarButton: UIBarButtonItem = {    //  lazy var => 呼び出された時に初期値決定
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self     //  targetで対象を指定
        rightBarButton.title = R.string.localizable.add()
        rightBarButton.style = .plain
        rightBarButton.action = #selector(didAddBarButtonTapped(_:))
        return rightBarButton
    }()
    
    // tableViewにBookListCellを登録する
    private lazy var bookTableView: UITableView = {
        let bookTable = UITableView()
        bookTable.frame = view.bounds
        bookTable.delegate = self
        bookTable.dataSource = self
        bookTable.register(BookListCell.self,
                           forCellReuseIdentifier: BookListCell.identifer)
        bookTable.rowHeight = 150
        return bookTable
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookListViewModel.update(books: [])
        sendBookListRequest(initial: true)
        
        view.addSubview(bookTableView)
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.booklist()
        navigationItem.hidesBackButton = true
        navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    //  API処理
    private func sendBookListRequest(initial: Bool) {
        bookListViewModel.setBookList(
            initial: initial,
            successAction: { [unowned self] in
                self.bookTableView.reloadData() },
            errorAction: { _ in }
        )
    }
    
    //  ”追加”ボタンが押された時の処理
    @objc private func didAddBarButtonTapped(_ sender: UIBarButtonItem) {
        let addBook: AddBookViewController = AddBookViewController()
        let addBookViewController = UINavigationController(rootViewController: addBook)
        present(addBookViewController, animated: true)
    }
    
    //  下スクロール時にAPI通信実施
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        
        if bookListViewModel.books.count >= 20 &&
            indexPath.row == ( bookListViewModel.books.count - 10) {
            
            sendBookListRequest(initial: false)
        }
    }
}

extension BookListViewController: UITableViewDataSource {
    //  セルをインスタンス化
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: BookListCell = (tableView.dequeueReusableCell(
            withIdentifier: BookListCell.identifer) as? BookListCell) else { return UITableViewCell() }
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.configure(book: bookListViewModel.books[indexPath.row])
        return cell
    }
    
    //  表示するセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookListViewModel.books.count
    }
}

extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        let book = bookListViewModel.books[indexPath.row]
        //  Rswiftを使ってstoryboardのインスタンス取得し、遷移先ViewControllerのインスタンス取得
        let editBookViewController = EditBookViewController.makeInstance(book: book)
        //  画面遷移
        navigationController?.pushViewController(editBookViewController, animated: true)
    }
}
