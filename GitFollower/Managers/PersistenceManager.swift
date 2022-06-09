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
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favoritesKeys = "favorite"
    }
    
    static func updateWith(favorite: FollowerModel , actionType: PersistenceActionType, completion: @escaping (ErrorMessages?) -> Void) {
        
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
                var retrivedFavorites = favorites
                
                switch actionType {
                case .add:
                    print(favorite)
                    print(retrivedFavorites.contains(favorite))
                    if retrivedFavorites.contains(favorite) {
                        print("ALREADT")
                        completion(.alreadyFavorited)
                        return
                    } else {
                        retrivedFavorites.append(favorite)
                    }
//                    guard !retrivedFavorites.contains(favorite) else {
//                        print("ALREADT")
//                        completion(.alreadyFavorited)
//                        return
//                    }
                    //retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll { $0.login == favorite.login}
                }
                completion(save(favorites: retrivedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    
    
    static func retriveFavorites(completion: @escaping (Result<[FollowerModel], ErrorMessages>) -> Void) {
        print("retrieve favorites")
        guard let favoriteData = defaults.object(forKey: Keys.favoritesKeys) as? Data else {
            completion(.success([]))
            return
        }
        print(favoriteData)
        
    
        do {
            let favorites = try JSONDecoder().decode([FollowerModel].self, from: favoriteData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unAbleToFavorite))
        }
    }
    
    
    static func save(favorites: [FollowerModel]) -> ErrorMessages? {
        print("save")
        print(favorites)
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
