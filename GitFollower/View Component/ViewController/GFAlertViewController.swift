//
//  GFAlertViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 27.05.22.
//

import UIKit

class GFAlertViewController: UIViewController {
    
    
    let containerView = UIView()
    let titleLabel = GFTitleLabel(textAligment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAligment: .center)
    let okButton = GFButton(backgroundColor: .systemRed, title: "OK")
    
    var alertTitle: String!
    var messageTitle: String!
    var buttonTitle: String!
    
    init(title: String,  message: String, button: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.messageTitle = message
        self.buttonTitle = button
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureBodyLabel()
    }
    
    
     func configureContainerView () {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
     func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    
     func configureButton() {
         containerView.addSubview(okButton)
         okButton.setTitle(buttonTitle, for: .normal)
         okButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
         okButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    
     func configureBodyLabel(){
        containerView.addSubview(bodyLabel)
        bodyLabel.text = messageTitle
        bodyLabel.numberOfLines = 4
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -12)
        ])
    }
    
    

}
