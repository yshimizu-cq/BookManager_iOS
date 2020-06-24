//
//  EditBookViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/23.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class EditBookViewController: UIViewController {

    @IBOutlet weak var imageUploadButtonTapped: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "編集中"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))

    }
    
    // ”完了”ボタンが押された時の処理
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
        
    // ”キャンセル”ボタンが押された時の処理
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameTextField(_ sender: UITextField) {
        nameTextField.text = sender.text
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
        priceTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }

}


