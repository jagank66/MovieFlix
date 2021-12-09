//
//  UICollectionView.swift
//  Movie Flix
//
//  Created by apple on 09/12/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(_ cellTypes: [String]) {
        for type in cellTypes {
            let nib = UINib.init(type)
            register(nib, forCellWithReuseIdentifier: type)
        }
    }
}

extension  UINib {
    
    convenience init(_ type: String) {
        self.init(nibName: type, bundle: nil)
    }
}

extension UICollectionView {
    func cardView() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 0
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        
        return section
    }
   
}
 
