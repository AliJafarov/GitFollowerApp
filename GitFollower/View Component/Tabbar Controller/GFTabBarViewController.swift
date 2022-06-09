//
//  GFTabBarViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 09.06.22.
//

import UIKit

class GFTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [creatSearchNC(), creatFavNC()]
        
    }
    

    func creatSearchNC () -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func creatFavNC () -> UINavigationController {
        let favVC = FavoriteViewController()
        favVC.title = "Favorites"
        favVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favVC)
    }
    
    

}
