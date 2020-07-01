//
//  EditBookViewController.swift
//  BookManager_iOS
//
//  Created by 清水雄大 on 2020/06/23.
//  Copyright © 2020 Yuta Shimizu. All rights reserved.
//

import UIKit

final class EditBookViewController: UIViewController {
    
    @IBOutlet weak var imageUploadButtonTapped: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = R.image.sample_image()
        }
    }
    
    private var datePicker: UIDatePicker = UIDatePicker()
    
    private lazy var rightBarButton: UIBarButtonItem = { [weak self] in     //  lazy var => 呼び出された時に初期値決定
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self     //  targetで対象を指定
        rightBarButton.title = R.string.localizable.save()
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
        let spacelitem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace,
                                              target: self,
                                              action: nil
        )
        return spacelitem
    }()
    
    private let doneItem: UIBarButtonItem = {
        let doneitem = UIBarButtonItem.init(barButtonSystemItem: .done,
                                            target: self,
                                            action: #selector(didDoneButtonTapped)
        )
        return doneitem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.edit()
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
        
        //  ピッカー設定
        dateTextField.inputView = purchaseDate
        toolBar.setItems([spacelItem, doneItem], animated: true)    //  決定バーの生成
        dateTextField.inputAccessoryView = toolBar  //  インプットビュー設定(紐づいているUITextfieldへ代入)
    }
    
    // ”保存”ボタンが押された時の処理
    @objc func didSaveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            let price = priceTextField.text,
            let date = dateTextField.text else {
                return
        }
        //　未入力チェック
        guard !title.isEmpty, !price.isEmpty, !date.isEmpty else {
            showAlert(message: R.string.localizable.blank())
            return
        }
    }
    
    // ”キャンセル”ボタンが押された時の処理
    @objc func didCancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapTitleReturn(_ sender: UITextField) {
        titleTextField.text = sender.text
    }
    
    
    @IBAction func didTapPriceReturn(_ sender: UITextField) {
        priceTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func didDoneButtonTapped() {
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定してあげることでdatePickerで指定した日付が表示される
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    // アラート表示
    private func showAlert(message: String) {
        let alert = UIAlertController(title: R.string.localizable.error(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okay(), style: .default))
        present(alert, animated: true)
    }
}
