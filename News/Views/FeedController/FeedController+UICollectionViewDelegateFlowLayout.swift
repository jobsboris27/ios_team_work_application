//
//  FeedController+UICollectionViewDelegateFlowLayout.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height)
    }
    
}
