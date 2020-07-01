//
//  BookListCell.swift
//  
//
//  Created by 清水雄大 on 2020/06/23.
//

import UIKit

final class BookListCell: UITableViewCell {
    
    static let identifer: String = "BookListCell"   //  BookListCell.identiferで呼び出せるようになる
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.sampleName()
        label.translatesAutoresizingMaskIntoConstraints = false    //   AutosizingのAutoLayoutへの変換をオフ
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.priceLabel(1000)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = R.string.localizable.sampleDate().replacingOccurrences(of: "-", with: "/")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bookImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(named: R.string.localizable.sampleImage())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier )
        addSubview(titleLabel)  //  Viewの配置
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(bookImageView)
        
        //  アンカー設定
        setAnchor()
    }
    
    private func setAnchor() {
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
