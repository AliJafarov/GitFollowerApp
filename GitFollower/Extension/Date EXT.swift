//
//  Date EXT.swift
//  GitFollower
//
//  Created by Ali Jafarov on 05.06.22.
//

import Foundation

extension Date {
    
    func convertDatetoString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
        
    }
    
}
