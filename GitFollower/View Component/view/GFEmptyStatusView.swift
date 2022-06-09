//
//  GFEmptyStatusLabel.swift
//  GitFollower
//
//  Created by Ali Jafarov on 02.06.22.
//

import UIKit

class GFEmptyStatusView: UIView {
    
    var messageLabel = GFTitleLabel(textAligment: .center, fontSize: 28)
    var emptyImageView =  UIImageView()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String){
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    

    private func configure() {
        
        addSubview(emptyImageView)
        addSubview(messageLabel)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        emptyImageView.image = UIImage(named: "backgit")
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.5),
            emptyImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.5),
            emptyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 165),
            emptyImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80)
        ])
    }
    

}
