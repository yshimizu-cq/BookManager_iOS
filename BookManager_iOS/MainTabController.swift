//
//  MainTabController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ページを格納する配列
        var viewControllers: [UIViewController] = []
        // BookListViewControllerを取得
        let bookList = UINavigationController(rootViewController: BookListViewController())
        bookList.tabBarItem = UITabBarItem(title: R.string.localizable.booklist(), image: nil, tag: 1)
        viewControllers.append(bookList)  // append => 配列に追加
        // AccountViewControllerを取得
        let account = R.storyboard.account.instantiateInitialViewController()!
        account.tabBarItem = UITabBarItem(title: R.string.localizable.account(), image: nil, tag: 2)
        viewControllers.append(account)
        self.setViewControllers(viewControllers, animated: false)
    }
}
