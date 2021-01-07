//
//  ViewController.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 02.01.2021.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCurrencyList { result in
            switch result {
                case .failure(let error):
                    print(error.rawValue)
                    break
                case .success(let response):
                    print(response)
                    break
            }
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath) as! CurrencyCollectionViewCell
        cell.layer.cornerRadius = 10
        
        NetworkManager.shared.getCurrencyList { result in
            switch result {
                case .failure(let error):
                    print(error.rawValue)
                    break
                case .success(let response):
                    print(response)
                    let curr = response[indexPath.row]
                    cell.currencyLabel.text = "\(curr.name) \n \(curr.value)"
                    break
            }
        }
        
        return cell
    }


}


