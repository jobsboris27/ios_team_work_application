//
//  FeedController+UICollectionViewDelegate.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == categoryCollectionView) {
            
            return categories.count
        }
        
        return currencyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath) {
                currentCategory = categories[indexPath.row]
                cell.backgroundColor = .gray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = .none
        }
    }
    
}
