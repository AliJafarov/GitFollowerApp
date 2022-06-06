//
//  GFImageView.swift
//  GitFollower
//
//  Created by Ali Jafarov on 31.05.22.
//

import UIKit

class GFImageView: UIImageView {
    
    let placeHolder = UIImage(named: "gitavatar")
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolder
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let cachkey = NSString(string: urlString)
        if let image = cache.object(forKey: cachkey) {
            
            self.image = image
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cachkey)
            DispatchQueue.main.async { self.image = image }
        }
        task.resume()
    }
    
    
    

}
