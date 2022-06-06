//
//  GFItemInfoVC.swift
//  GitFollower
//
//  Created by Ali Jafarov on 05.06.22.
//

import UIKit



class GFItemInfoVC: UIViewController {
    
    var user: UserModel!
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFInfoItemView()
    let itemInfoViewTwo = GFInfoItemView()
    let actionButton = GFButton()
    
    weak var delegate: UserInfoViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBackground()
        layoutUI()
        configureStackView()
        configureActionButton()
        
    }
    
    init(user: UserModel){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureBackground(){
        
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 17
    }
    
    
    func configureActionButton(){
        
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
    }
    
    @objc func actionTapped() {
        
        
    }
    
    private func configureStackView() {
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }
    
    private func layoutUI(){
        
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    


}
