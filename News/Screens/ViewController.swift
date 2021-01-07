//
//  ViewController.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 02.01.2021.
//

import UIKit

class ViewController: UIViewController {
  // MARK: IBOutlets
  @IBOutlet var currencyCollectionView: UICollectionView!
  
  // MARK: Private properties
  private var currencyList: [Currency] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        currencyCollectionView.delegate = self
        currencyCollectionView.dataSource = self

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
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return currencyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath) as! CurrencyCollectionViewCell
        cell.layer.cornerRadius = 10
        
        cell.label.text = currencyList[indexPath.row].name
        cell.value.text = currencyList[indexPath.row].value

        return cell
    }
}


