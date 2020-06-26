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
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.parent?.navigationItem.title = "編集中"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))
        
        imageView.image = UIImage(named: "sample_image")
        
        // ピッカー設定
        datePicker.date = Date()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja")
        dateTextField.inputView = datePicker

        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        // インプットビュー設定(紐づいているUITextfieldへ代入)
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
    }
    
    // ”保存”ボタンが押された時の処理
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text,
              let price = priceTextField.text,
            let date = dateTextField.text else {
            return
        }
        //　未入力チェック
        guard !title.isEmpty, !price.isEmpty, !date.isEmpty else {
            alertMessage(message: "未入力項目があります")
            return
        }
        
    }
        
    // ”キャンセル”ボタンが押された時の処理
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func titleTextField(_ sender: UITextField) {
        titleTextField.text = sender.text
    }
    
    @IBAction func priceTextField(_ sender: UITextField) {
        priceTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    @objc func done() {
        
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定してあげることでdatePickerで指定した日付が表示される
        dateTextField.text = "\(formatter.string(from: datePicker.date))"

    }
    
    // アラート表示
    private func alertMessage(message: String) {
        let alert = UIAlertController(title: "入力エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }

}


