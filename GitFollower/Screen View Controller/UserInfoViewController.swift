//
//  UserInfoViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 04.06.22.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    
    func didTappedGoToProfileButton(for user: UserModel)
    func didTappedGetFollowerButton(for user: UserModel)
    
}

class UserInfoViewController: UIViewController {
    
    var username: String?
    var headerView = UIView()
    var itemViewOne = UIView()
    var itemViewTwo = UIView()
    var itemViewsArray: [UIView] = []
    var dateLabel = GFBodyLabel(textAligment: .center)
    
    weak var delegate: FollowersViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDidload()
        getUserInfo()
        layoutViews()
        
    }
    
    
    
    private func configureViewDidload() {
        
        print(username!)
        view.backgroundColor = .systemBackground
        let rightBatButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissController))
        navigationItem.rightBarButtonItem = rightBatButton
        
    }
    
    @objc func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    private func getUserInfo(){
        
        NetworkManager.shared.getUserInfo(for: username!) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElement(user: user) }
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureUIElement(user: UserModel){
        
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: UserHeaderViewController(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "Github since \(user.created_at!.convetToDisplayFormat())"
    }

    
    private func layoutViews(){
        
        itemViewsArray = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for items in itemViewsArray {
            
            view.addSubview(items)
            items.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 30),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
        
        
    }
    
    private func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    
    
    func didTappedGoToProfileButton(for user: UserModel) {
        guard let url = URL(string: user.html_url) else {
            presentGFAlert(title: "Invalid UserNameURL", message: "This Url could not have been found", buttonTitle: "OK")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTappedGetFollowerButton(for user: UserModel) {
        guard user.followers != 0 else {
            presentGFAlert(title: "No Follower", message: "This User Has no follower", buttonTitle: "OK")
            return
        }
        
        delegate.didRequestFollowerUsername(for: user.login)
        dismissController()
    }
    
    
    
    
   
    
}
