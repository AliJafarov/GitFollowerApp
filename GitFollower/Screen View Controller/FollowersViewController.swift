//
//  FollowersViewController.swift
//  GitFollower
//
//  Created by Ali Jafarov on 27.05.22.
//

import UIKit

protocol FollowersViewControllerDelegate: class {
    func didRequestFollowerUsername(for username: String)
    
}

class FollowersViewController: UIViewController {
    
    
    enum Section: Hashable {
        case main
    }
    
    var collectionView: UICollectionView!
    var userName: String!
    var followerArray: [FollowerModel] = []
    var filteredFollowerArray: [FollowerModel] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!
    var page = 1
    var haveMoreFollower = true
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewDidLoad()
        configureSearchController()
        configureCollectionView()
        getData(username: userName, page: page)
        configureDataSource()
        
        
    }
    
    
    func configureViewDidLoad(){
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = userName
        let rightBatButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = rightBatButton
        
    }
    
    @objc func addButtonTapped() {
        
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite = FollowerModel(login: user.login, avatar_url: user.avatar_url)
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlert(title: "Success", message: "You have succesfully favorited this user", buttonTitle: "Close")
                        return
                    }
                    self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
                
            case .failure(let error):
                self.presentGFAlert(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
        
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
        
    }
    
    func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Enter a username"
        navigationItem.searchController = searchController
    }
    
    
    func getData(username: String, page: Int){
        
        showLoadingView()
        NetworkManager.shared.getFollower(for: userName, page: page) { [weak self] result in
            
            guard let self = self else {return}
            self.dismissLoadingView()
            switch result {
            case .success(let follower):
                if follower.count < 30 { self.haveMoreFollower = false }
                self.followerArray.append(contentsOf: follower)
                if self.followerArray.isEmpty {
                    let message = "This user does not have any follower"
                    DispatchQueue.main.async {
                        self.showEmptyState(for: message, for: self.view)
                        return
                    }
                }
                self.updateData(on: self.followerArray)
            case .failure(let error):
                self.presentGFAlert(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, FollowerModel>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(data: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [FollowerModel]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil) }
    }
}



extension FollowersViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let ofsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if ofsetY > contentHeight - screenHeight {
            guard haveMoreFollower else { return }
            page += 1
            getData(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeFollower = isSearching ? filteredFollowerArray : followerArray
        let follower = activeFollower[indexPath.row]
        let destinationVC = UserInfoViewController()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true, completion: nil)
        
        
    }
    
    
}

extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowerArray = followerArray.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowerArray)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followerArray)
    }
}

extension FollowersViewController: FollowersViewControllerDelegate {
    
    func didRequestFollowerUsername(for username: String) {
        self.userName = username
        title = username
        page = 1
        followerArray.removeAll()
        filteredFollowerArray.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getData(username: username, page: page)
        
    }
    
    
    
}
