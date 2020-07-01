//
//  UIAlertExtension.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/01.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//
import UIKit

public extension UIViewController {
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: R.string.localizable.error(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okay(), style: .default))
        present(alert, animated: true)
    }
}
