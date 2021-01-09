//
//  FeedController+UICollectionViewDelegateFlowLayout.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            
            return CGSize(width: cell.label.frame.width + 50, height: cell.label.frame.height)
        }
        
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
}
