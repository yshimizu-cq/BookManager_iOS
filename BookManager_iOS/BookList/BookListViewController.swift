//
//  BookListViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController{
    
    var tableView: UITableView?
    let items = ["Sample1","Sample2","Sample3"]
    
    // バーボタンアイテムの宣言
    var addBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "書籍一覧"
        self.parent?.navigationItem.hidesBackButton = true
        
//        self.tableView = {
//          let tableView = UITableView(frame: self.view.bounds, style: .plain)
//          tableView.autoresizingMask = [
//            .flexibleWidth,
//            .flexibleHeight
//          ]
//          tableView.delegate = self
//          tableView.dataSource = self
//
//          self.view.addSubview(tableView)
//
//          return tableView
//
//        }()
        
        // バーボタンアイテムの初期化
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
        // バーボタンアイテムの追加　↓ここが本当に追加したいところであっているか
        self.navigationItem.rightBarButtonItem = addBarButtonItem

    }
    
    // ボタンが押された時の処理
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      print("Selected! \(self.items[indexPath.row])")
//    }
    
    // ”追加”ボタンが押された時の処理
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem) {

    }
    
}
