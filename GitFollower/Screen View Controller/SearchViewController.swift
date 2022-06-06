//
//  SearchViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 26.05.22.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImage = UIImageView()
    let searchText = GFTextField()
    let actionButton = GFButton(backgroundColor: .systemGreen, title: "Get Follower")
    var userNameEntered: Bool { return !searchText.text!.isEmpty }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureImageView()
        configureTextField()
        configureButton()
        dismissKeyboard()

    }
    
    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerVC(){
        
        guard userNameEntered else {
            presentGFAlert(title: "Empty", message: "Please provide a username", buttonTitle: "OK")
    
            return
        }
        let followerVC = FollowersViewController()
        followerVC.userName = searchText.text
        followerVC.title = searchText.text
        navigationController?.pushViewController(followerVC, animated: true)
        
    }
    
    
    private func configureImageView (){
        
        view.addSubview(logoImage)
        logoImage.image = UIImage(named: "gitlogo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    private func configureTextField(){
        
        view.addSubview(searchText)
        searchText.delegate = self
        searchText.text = "NigarJafar"
        NSLayoutConstraint.activate([
            searchText.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 44),
            searchText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureButton() {
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(pushFollowerVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerVC()
        return true
    }
    
}
