//
//  AddBookViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/22.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UITextFieldDelegate {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.bookName()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.price()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.purchaseDate()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var datePicker: UIDatePicker = UIDatePicker()
    
    private let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: R.string.localizable.sampleImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let imageUploadButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.attachedImage(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(didImageUploadButtonTapped(_ :)), for: .touchUpInside)
        return button
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = { [weak self] in     //  lazy var => 呼び出された時に初期値決定
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self     //  targetで対象を指定
        rightBarButton.title = R.string.localizable.done()
        rightBarButton.style = .plain
        rightBarButton.action = #selector(didSaveButtonTapped(_:))
        return rightBarButton
    }()
    
    private lazy var leftBarButton: UIBarButtonItem = { [weak self] in
        let leftBarButton = UIBarButtonItem()
        leftBarButton.target = self     //  targetで対象を指定
        leftBarButton.title = R.string.localizable.cancel()
        leftBarButton.style = .plain
        leftBarButton.action = #selector(didCancelButtonTapped(_:))
        return leftBarButton
    }()
    
    private let purchaseDate: UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = Date()
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.locale = Locale(identifier: "ja")
        return picker
    }()
    
    private lazy var toolBar: UIToolbar = { [weak self] in
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        return toolbar
    }()
    
    private let spacelItem: UIBarButtonItem = {
        let spacelitem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        return spacelitem
    }()
    
    private let doneItem: UIBarButtonItem = {
        let doneitem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(didDoneButtonTapped))
        return doneitem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.resister()
        
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        titleTextField.delegate = self
        priceTextField.delegate = self
        dateTextField.delegate = self
        
        //  アンカー設定
        setAnchor()
        
        //  ピッカー設定
        dateTextField.inputView = purchaseDate
        toolBar.setItems([spacelItem, doneItem], animated: true)    //  決定バーの生成
        dateTextField.inputAccessoryView = toolBar  //  インプットビュー設定(紐づいているUITextfieldへ代入)
        
    }
    
    private func setAnchor() {
        
        view.addSubview(titleLabel)
        view.addSubview(titleTextField)
        view.addSubview(priceLabel)
        view.addSubview(priceTextField)
        view.addSubview(dateLabel)
        view.addSubview(dateTextField)
        view.addSubview(bookImageView)
        view.addSubview(imageUploadButton)
        
        bookImageView.leftAnchor.constraint(equalTo: titleTextField.leftAnchor).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: titleTextField.topAnchor, constant: -150).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        imageUploadButton.rightAnchor.constraint(equalTo: titleTextField.rightAnchor).isActive = true
        imageUploadButton.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor).isActive = true
        imageUploadButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageUploadButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: titleTextField.leftAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor).isActive = true
        
        priceTextField.leftAnchor.constraint(equalTo: titleTextField.leftAnchor).isActive = true
        priceTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50).isActive = true
        priceTextField.widthAnchor.constraint(equalTo: titleTextField.widthAnchor).isActive = true
        priceTextField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: priceTextField.leftAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: priceTextField.topAnchor).isActive = true
        
        dateTextField.leftAnchor.constraint(equalTo: bookImageView.leftAnchor).isActive = true
        dateTextField.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 50).isActive = true
        dateTextField.widthAnchor.constraint(equalTo: titleTextField.widthAnchor).isActive = true
        dateTextField.heightAnchor.constraint(equalTo: titleTextField.heightAnchor).isActive = true
        
        dateLabel.leftAnchor.constraint(equalTo: dateTextField.leftAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: dateTextField.topAnchor).isActive = true
        
    }
    
    //  ”完了”ボタンが押された時の処理
    @objc func didSaveButtonTapped(_ sender: UIBarButtonItem) {
        
        guard let title = titleTextField.text,
            let price = priceTextField.text,
            let date = dateTextField.text else {
                return
        }
        //  未入力チェック
        guard !title.isEmpty, !price.isEmpty, !date.isEmpty else {
            showAlert(message: R.string.localizable.blank())
            return
        }
        
    }
    
    // ”キャンセル”ボタンが押された時の処理
    @objc func didCancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    // ”画像投稿”ボタンが押された時の処理
    @objc func didImageUploadButtonTapped(_ sender: UIBarButtonItem) {
        
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
    
    @objc func didDoneButtonTapped() {
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定することでdatePickerで指定した日付が表示される
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    // アラート表示
    private func showAlert(message: String) {
        let alert = UIAlertController(title: R.string.localizable.error(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okay(), style: .default))
        present(alert, animated: true)
    }
    
}
