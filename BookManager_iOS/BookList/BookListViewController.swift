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
    let items: [String] = ["Sample1", "Sample2", "Sample3"]
    let sampleImage = UIImage(named: "sample_image")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "書籍一覧"
        self.parent?.navigationItem.hidesBackButton = true
        
        // tableView に BookListCell を登録する
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BookListCell", bundle: nil), forCellReuseIdentifier: "BookListCell")
        view.addSubview(tableView)
        
        // バーボタンアイテムの追加
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))

    }
    
    //  表示するセルの数を指定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //  表示するセルの内容を指定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell") as? BookListCell
        cell.title.text = "samplebook"
        cell.price.text = "3000円"
        cell.date.text = "2020/06/20"
        cell.sampleImage.image = sampleImage
        return cell
    }
    
    //  ”追加”ボタンが押された時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let addBook: AddBookViewController = AddBookViewController()
        let navigationController = UINavigationController(rootViewController: addBook)
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
