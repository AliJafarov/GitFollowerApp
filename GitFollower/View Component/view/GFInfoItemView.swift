//
//  GFInfiItemView.swift
//  GitFollower
//
//  Created by Ali Jafarov on 04.06.22.
//

import UIKit

enum ItemInfoType {
    
    case repos , gists, followers , followings
}


class GFInfoItemView: UIView {
    

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
    let counterLabel = GFTitleLabel(textAligment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(counterLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleToFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            counterLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemType: ItemInfoType, with count: Int) {
        
        switch itemType {
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text = "Follower"
        case .followings:
            symbolImageView.image = UIImage(systemName: "person.2")
            titleLabel.text = "Following"
        }
        counterLabel.text = String(count)
    }
    
    
}
