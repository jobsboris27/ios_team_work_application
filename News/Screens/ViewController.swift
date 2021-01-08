//
//  ViewController.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 02.01.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
  // MARK: IBOutlets
    @IBOutlet var currencyCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    let category = ["Popular", "Sports", "Insider", "Auto", "Science"]
    
  // MARK: Private properties
    private var currencyList: [Currency] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self

        NetworkManager.shared.getCurrencyList { [weak self] result in
            switch result {
                case .failure(let error):
                    print(error.rawValue)
                    break
                case .success(let response):
                  DispatchQueue.main.async {
                    self?.currencyList = response
                    self?.currencyCollectionView.reloadData()
                  }
                  break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == categoryCollectionView) {
            return category.count
        }
        return currencyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath) as! CurrencyCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.label.text = currencyList[indexPath.row].name
        cell.value.text = currencyList[indexPath.row].value
        
        if collectionView == categoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryLabel.text = category[indexPath.row]
            categoryCell.backgroundColor = .blue
            return categoryCell
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
            cell.backgroundColor = .none
        }
    }
}



