//
//  FavoritesTableViewCell.swift
//  GitFollower
//
//  Created by Ali Jafarov on 08.06.22.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    
    var userImageView = GFImageView(frame: .zero)
    var userNameLabel = GFTitleLabel(textAligment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(data: FollowerModel){
        userNameLabel.text = data.login
        userImageView.downloadImage(from: data.avatar_url)

    }
    
    private func configure () {
        
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        accessoryType = .disclosureIndicator
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        userImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 24).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        
    }
    
    
    
    
    

}
