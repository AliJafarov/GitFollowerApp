//
//  GFRepoItemVC.swift
//  GitFollower
//
//  Created by Ali Jafarov on 05.06.22.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    func configureItems() {
        
        itemInfoViewOne.set(itemType: .repos, with: user.public_repos)
        itemInfoViewTwo.set(itemType: .gists, with: user.public_gists)
        actionButton.set(backGroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionTapped() {
        delegate.didTappedGoToProfileButton(for: user)
    }
    
}

