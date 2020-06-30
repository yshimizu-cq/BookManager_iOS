//
//  BookListViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //    var addBookButton: UIBarButtonItem!
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "書籍一覧"
        navigationItem.hidesBackButton = true
        
        // tableViewにBookListCellを"cell"という名前で登録する
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookListCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // バーボタンアイテムの追加
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))
        
    }
    
    //  表示するセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    //  セルをインスタンス化
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    //    セルの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //  ”追加”ボタンが押された時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let addBook: AddBookViewController = AddBookViewController()
        let addBookViewController = UINavigationController(rootViewController: addBook)
        self.present(addBookViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.editBook()
        //  遷移先ViewControllerのインスタンス取得
        guard let editBookViewController = storyboard.instantiateInitialViewController() as? EditBookViewController else { return }
        //  画面遷移
        navigationController?.pushViewController(editBookViewController, animated: true)
    }
    
}
