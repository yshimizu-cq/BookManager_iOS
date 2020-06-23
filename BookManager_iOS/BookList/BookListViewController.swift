//
//  BookListViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView: UITableView?
    let items = ["Sample1","Sample2","Sample3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "書籍一覧"
        self.parent?.navigationItem.hidesBackButton = true
        
        self.tableView = {
          let tableView = UITableView(frame: self.view.bounds, style: .plain)
          tableView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
          ]
          tableView.delegate = self
          tableView.dataSource = self

          self.view.addSubview(tableView)

          return tableView

        }()
        
        // バーボタンアイテムの追加
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "追加", style: .plain, target: self, action: #selector(addBarButtonTapped(_:)))


    }
    
    //  ボタンが押された時の処理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected! \(self.items[indexPath.row])")
    }
    
    //  ”追加”ボタンが押された時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {
        let addBook: AddBookViewController = AddBookViewController()
        let navigationController = UINavigationController(rootViewController: addBook)
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
