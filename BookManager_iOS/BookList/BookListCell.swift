//
//  BookListCell.swift
//  
//
//  Created by 清水雄大 on 2020/06/23.
//

import UIKit

final class BookListCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "書籍名"
        label.translatesAutoresizingMaskIntoConstraints = false    //   AutosizingのAutoLayoutへの変換をオフ
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "価格"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "購入日"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: "sample_image")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier )
        addSubview(titleLabel)  //  Viewの配置
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(bookImageView)
        
        //  Anchor指定（値は後で要修正）
        titleLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 50).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 50).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -50).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        
        bookImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
