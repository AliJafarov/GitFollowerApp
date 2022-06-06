//
//  FollowerCollectionViewCell.swift
//  GitFollower
//
//  Created by Ali Jafarov on 31.05.22.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    var userImageView = GFImageView(frame: .zero)
    var userNameLabel = GFTitleLabel(textAligment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(data: FollowerModel){
        userNameLabel.text = data.login
        userImageView.downloadImage(from: data.avatar_url)

    }
    
    
    private func configure() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
    
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    
    
}
