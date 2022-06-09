//
//  GFAlertContainerView.swift
//  GitFollower
//
//  Created by Ali Jafarov on 09.06.22.
//

import UIKit

class GFAlertContainerView: UIView {
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        
    }

}
