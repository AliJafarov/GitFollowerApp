//
//  GFFollowerVC.swift
//  GitFollower
//
//  Created by Ali Jafarov on 05.06.22.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
        
    }
    
    func configureItems() {
        
        itemInfoViewOne.set(itemType: .followers, with: user.followers)        
        itemInfoViewTwo.set(itemType: .followings, with: user.following)
        actionButton.set(backGroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionTapped() {
        delegate.didTappedGetFollowerButton(for: user)
    }
}
