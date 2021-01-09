//
//  FeedController+UICollectionViewDataSource.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.label.text = categories[indexPath.row]
            categoryCell.layer.cornerRadius = 10
            
            return categoryCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath) as! CurrencyCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.label.text = currencyList[indexPath.row].name
        cell.value.text = currencyList[indexPath.row].value
        
        return cell
    }
    
}
