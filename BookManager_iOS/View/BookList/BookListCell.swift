//
//  BookListCell.swift
//  
//
//  Created by 清水雄大 on 2020/06/23.
//

import UIKit
import Nuke

final class BookListCell: UITableViewCell {
    
    static let identifer: String = "BookListCell"   //  BookListCell.identiferで呼び出せるようになる
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false    //   AutosizingのAutoLayoutへの変換をオフ
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier )
        [titleLabel, priceLabel, dateLabel, bookImageView].forEach { addSubview($0) }   //  Viewの配置
        setAnchor() //  アンカー設定
    }
    
    private func setAnchor() {
        titleLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 20).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        bookImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(book: Book) {
        titleLabel.text = book.name
        priceLabel.text = "\(String(book.price))\(R.string.localizable.yen())"
        dateLabel.text = book.purchaseDate
        
        if let imageURL = book.image, let url = URL(string: imageURL) {
            Nuke.loadImage(with: url, into: bookImageView)
        }
    }
}
