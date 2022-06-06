//
//  UserModel.swift
//  GitFollower
//
//  Created by Ali Jafarov on 28.05.22.
//

import Foundation

struct UserModel: Codable {
    
    var login: String
    var avatar_url: String
    var name: String?
    var location: String?
    var bio: String?
    var created_at: String?
    var followers: Int
    var following: Int
    var public_repos: Int
    var public_gists: Int
    var html_url: String

}
