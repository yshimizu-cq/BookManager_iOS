//
//  BookListViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "書籍一覧"
        self.parent?.navigationItem.hidesBackButton = true
        
        // tableViewにBookListCellを"cell"という名前で登録する
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookListCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // バーボタンアイテムの追加
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))

    }
    
    //  表示するセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    //  セルをインスタンス化
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    //    セルの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //  ”追加”ボタンが押された時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let addBook: AddBookViewController = AddBookViewController()
        let navigationController = UINavigationController(rootViewController: addBook)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.editBook()
        //  遷移先ViewControllerのインスタンス取得
        guard let editBookView = storyboard.instantiateInitialViewController() as? EditBookViewController else { return }
        //  画面遷移
        navigationController?.pushViewController(editBookView, animated: true)
    }
    
}
