//
//  ViewController.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 02.01.2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  // MARK: IBOutlets
    @IBOutlet var currencyCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
  // MARK: Private properties
    private let category = ["Popular", "Sports", "Insider", "Auto", "Science"]

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
        if collectionView == categoryCollectionView {
            let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            categoryCell.categoryLabel.text = category[indexPath.row]
            categoryCell.layer.cornerRadius = 10
            return categoryCell
        }
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath) as! CurrencyCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.label.text = currencyList[indexPath.row].name
        cell.value.text = currencyList[indexPath.row].value

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            if let cell = collectionView.cellForItem(at: indexPath){
                cell.backgroundColor = .none
            }
        }
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            return CGSize(width: cell.categoryLabel.frame.width + 50, height: cell.categoryLabel.frame.height)
        }
        
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}

