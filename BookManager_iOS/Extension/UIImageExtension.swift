//
//  UIImageExtension.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/07/13.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    static func showImage(url: URL, imageView: UIImageView) {
        Nuke.loadImage(with: url, into: imageView)
    }
}
