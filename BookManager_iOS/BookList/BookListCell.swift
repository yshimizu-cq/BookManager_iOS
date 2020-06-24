//
//  BookListCell.swift
//  
//
//  Created by 清水雄大 on 2020/06/23.
//

import UIKit

class BookListCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "タイトル"
        label.translatesAutoresizingMaskIntoConstraints = false    //   AutosizingのAutoLayoutへの変換をオフ
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "価格"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "購入日"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
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
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        priceLabel.leftAnchor.constraint(equalTo: bookImageView.rightAnchor, constant: 50).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        bookImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        bookImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        bookImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
