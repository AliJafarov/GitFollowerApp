//
//  ErrorMessages.swift
//  GitFollower
//
//  Created by Ali Jafarov on 31.05.22.
//

import Foundation

enum ErrorMessages: String, Error {
    
    case invalidUsername = "This username has not been found . Please try again"
    case unableToComplete  = "Unable to complete your request . Please check your internet connection"
    case invalidResponse = "Invalid response from server . Please try again"
    case invalidData = "The data recieved from the server was invalid"
    case unAbleToFavorite = "There was an error fovoriting this user. Please try again later"
    
}

