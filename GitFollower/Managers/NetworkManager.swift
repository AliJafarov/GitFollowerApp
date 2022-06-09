//
//  NetworkManager.swift
//  GitFollower
//
//  Created by Ali Jafarov on 29.05.22.
//


import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}
    
    func getFollower(for username: String , page: Int , completion: @escaping (Result<[FollowerModel], ErrorMessages>) -> Void ) {
        let endPoint = baseUrl + "\(username)/followers?per_page100&page=/\(page)"
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            
            return
        }
        print(endPoint)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else  {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data  else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([FollowerModel].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
    
    func getUserInfo(for username: String , completion: @escaping (Result<UserModel, ErrorMessages>) -> Void ) {
        let endPoint = baseUrl + "\(username)"
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            
            return
        }
        print(endPoint)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else  {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data  else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(UserModel.self, from: data)
                completion(.success(result))
            }
            catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    
}

