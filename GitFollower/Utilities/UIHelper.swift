//
//  UIHelper.swift
//  GitFollower
//
//  Created by Ali Jafarov on 02.06.22.
//

import UIKit

struct UIHelper {
    
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumSpace: CGFloat = 10
        let availableSpace = width - (padding * 2) - (minimumSpace * 2)
        let itemWidth = availableSpace / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40.0)
        
        return flowLayout
    }
    
    
    
}
