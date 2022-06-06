//
//  PersistenceManager.swift
//  GitFollower
//
//  Created by Ali Jafarov on 06.06.22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    enum Keys {
        static let favoritesKeys = "favorite"
    }
    
    
    
    
    static func retriveFavorites(completion: @escaping (Result<[FollowerModel], ErrorMessages>) -> Void) {
        
        guard let favoriteData = defaults.object(forKey: Keys.favoritesKeys) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let favorites = try JSONDecoder().decode([FollowerModel].self, from: favoriteData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unAbleToFavorite))
        }
    }
    
    
    static func save(favorites: [FollowerModel]) -> ErrorMessages? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favoritesKeys)
            return nil
        } catch {
            return .unAbleToFavorite
        }
    }
}
