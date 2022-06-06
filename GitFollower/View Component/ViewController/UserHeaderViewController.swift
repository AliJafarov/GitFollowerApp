//
//  UserHeaderViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 04.06.22.
//

import UIKit

class UserHeaderViewController: UIViewController {
    
    var user: UserModel!
    
    let avatarImageview = GFImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAligment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAligment: .left)
    
    
    init(user: UserModel){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviewToView()
        layoutConstaints()
        configureUIElements()
        

    }
    
    private func configureUIElements() {
        
        avatarImageview.downloadImage(from: user.avatar_url)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location
        bioLabel.text = user.bio
        
        bioLabel.numberOfLines = 3
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = .secondaryLabel
        
    }
    
    private func addSubviewToView() {
        
        view.addSubview(avatarImageview)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    private func layoutConstaints() {
        
        let padding: CGFloat = 20
        let textPadding: CGFloat = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avatarImageview.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageview.widthAnchor.constraint(equalToConstant: 90),
            avatarImageview.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageview.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textPadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageview.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textPadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageview.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: textPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageview.bottomAnchor, constant: textPadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageview.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    
    


}
