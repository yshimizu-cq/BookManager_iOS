//
//  MainTabController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ページを格納する配列
        var viewControllers: [UIViewController] = []
               
        // 1ページ目のViewController
        let bookListViewController = BookListViewController()
        bookListViewController.tabBarItem = UITabBarItem(title: "書籍一覧", image: nil, tag: 1)
        viewControllers.append(bookListViewController)  // append => 配列に追加

        // 2ページ目のViewController
        //  Rswiftを使ってstoryboardのインスタンス取得
        let storyboard: UIStoryboard = R.storyboard.account()
        //  AccountViewControllerのインスタンス取得
        guard let accountViewController = storyboard.instantiateInitialViewController() as? AccountViewController else { return }
        accountViewController.tabBarItem = UITabBarItem(title: "アカウント", image: nil, tag: 2)
        viewControllers.append(accountViewController)

        self.setViewControllers(viewControllers, animated: false)

        self.selectedIndex = 0

    }

}
