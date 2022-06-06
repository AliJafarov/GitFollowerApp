//
//  FollowerModel.swift
//  GitFollower
//
//  Created by Ali Jafarov on 28.05.22.
//

import Foundation

struct FollowerModel: Codable, Hashable {
    
    let id = UUID()
    var login: String
    var avatar_url: String
    
}
