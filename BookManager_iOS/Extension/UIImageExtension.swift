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
    
    //  呼び出し元のimageViewはUIImageView型、selfで呼び出せる
    func showImage(url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}

extension UIImage {
    
    var asBase64EncodedString: String? {
        self.pngData()?.base64EncodedString()
    }
}
