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
    
    private lazy var rightBarButton: UIBarButtonItem = {    //  lazy var => 呼び出された時に初期値決定
        let rightBarButton = UIBarButtonItem()
        rightBarButton.target = self     //  targetで対象を指定
        rightBarButton.title = R.string.localizable.save()
        rightBarButton.style = .plain
        rightBarButton.action = #selector(didSaveButtonTapped(_:))
        return rightBarButton
    }()
    
    private lazy var leftBarButton: UIBarButtonItem = {
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
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
        return toolbar
    }()
    
    private lazy var spacelItem: UIBarButtonItem = {
        let spacelitem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                         target: self,
                                         action: nil
        )
        return spacelitem
    }()
    
    private lazy var doneItem: UIBarButtonItem = {
        let doneitem = UIBarButtonItem(barButtonSystemItem: .done,
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
    @objc private func didSaveButtonTapped(_ sender: UIBarButtonItem) {
        //　nilチェック
        guard let title = titleTextField.text,
            let price = priceTextField.text,
            let date = dateTextField.text,
            //　未入力チェック
            !title.isEmpty,
            !price.isEmpty,
            !date.isEmpty else {
                showAlert(message: R.string.localizable.blank())
                return
        }
    }
    
    // ”キャンセル”ボタンが押された時の処理
    @objc private func didCancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapTitleReturn(_ sender: UITextField) {
        titleTextField.text = sender.text
    }
    
    @IBAction func didTapPriceReturn(_ sender: UITextField) {
        priceTextField.text = sender.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func didDoneButtonTapped() {
        dateTextField.endEditing(true)
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        //(from: datePicker.date))を指定してあげることでdatePickerで指定した日付が表示される
        dateTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureObserver()    //  Notification発行
    }
    
    // Notificationを設定 => キーボードの表示・非表示を検知
    private func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self,
                                 selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil
        )
        notification.addObserver(self,
                                 selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil
        )
    }
    
    // キーボードが現れた時に画面全体をずらす
    @objc private func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
    }
    
    // キーボードが消えたときに、画面を戻す
    @objc private func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
    }
}
