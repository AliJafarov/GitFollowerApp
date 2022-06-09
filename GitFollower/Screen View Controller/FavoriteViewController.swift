//
//  FavoriteViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 26.05.22.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let tableView = UITableView()
    var favoritesArray: [FollowerModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDidload()
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func getData () {
        
        PersistenceManager.retriveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                print(favorites)
                if favorites.isEmpty {
                    self.showEmptyState(for: "You have not yet added user", for: self.view)
                } else {
                    self.favoritesArray = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlert(title: "AAAAAAA", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        
    }
    
    private func configureViewDidload(){
        view.backgroundColor = . systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.frame = view.bounds
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
    }

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as! FavoritesTableViewCell
        let favorite = favoritesArray[indexPath.row]
        cell.set(data: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favoritesArray[indexPath.row]
        let destVC = FollowersViewController()
        destVC.userName = favorite.login
        destVC.title =  favorite.login
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favoritesArray[indexPath.row]
        favoritesArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentGFAlert(title: "Unable to remove this user", message: error.rawValue, buttonTitle: "ok")
        }
        
    }
    
}
