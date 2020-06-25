//
//  AddBookViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate{
    
    //  UIコード実装
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "書籍名"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "価格"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "購入日"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var datePicker: UIDatePicker = UIDatePicker()

    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sample_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let imageUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("画像添付", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil ,action: #selector(imageUploadButtonTapped(_ :)),for: .touchUpInside)  //  "画像投稿"ボタンタップで実行
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "登録"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(saveButtonTapped(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "キャンセル", style: .plain, target: self, action: #selector(cancelButtonTapped(_:)))
        
        titleTextField.delegate = self
        priceTextField.delegate = self
        dateTextField.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateTextField)
        view.addSubview(bookImageView)
        view.addSubview(imageUploadButton)
        
        bookImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 50).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        imageUploadButton.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 60).isActive = true
        imageUploadButton.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor).isActive = true
        imageUploadButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageUploadButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleTextField.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true

        priceTextField.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        priceTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50).isActive = true
        priceTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        priceTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceTextField.topAnchor).isActive = true
        
        dateTextField.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        dateTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 50).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: dateTextField.topAnchor).isActive = true
        
        
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
    
    // ”完了”ボタンが押された時の処理
    @objc func saveButtonTapped(_ sender: UIBarButtonItem) {
        
    }
        
    // ”キャンセル”ボタンが押された時の処理
    @objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // ”画像投稿”ボタンが押された時の処理
    @objc func imageUploadButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    //  returnでキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        return true
    }
    
    //  画面タップでキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func done() {
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定することでdatePickerで指定した日付が表示される
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
    }

}
