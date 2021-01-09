//
//  FeedController.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

class FeedController: UIViewController {
  // MARK: IBOutlets
  @IBOutlet var currencyCollectiionView: UICollectionView!
  @IBOutlet var categoryCollectionView: UICollectionView!
  @IBOutlet var feedTableView: FeedTableView!
  
  // MARK: Private properties
  private let categories = ["Popular", "Sports", "Insider", "Auto", "Science"]
  private var currencyList: [Currency] = []

  // MARK: Public properties
  public var articles: [Article] = []
  
  public var currentCategory: String = "Popular" {
    didSet {
      if (currentCategory == "Popular") {
        loadPupolarArticles()
      } else {
        loadArticlesByCategory(category: currentCategory.lowercased())
      }
    }
  }
  

  // MARK: Private methods
  private func loadPupolarArticles() {
    NetworkManager.shared.getPopularArticles() { [weak self] result in
      switch result {
      case .failure(let error):
        print(error.rawValue)
        break
      case .success(let response):
        self?.articles = response
        DispatchQueue.main.async { self?.feedTableView.reloadData() }
        break
      }
    }
  }
  
  private func loadArticlesByCategory(category: String) {
    NetworkManager.shared.getArticlesByCategory(category: category) { [weak self] result in
      switch result {
      case .failure(let error):
        print(error.rawValue)
        break
      case .success(let response):
        self?.articles = response
        DispatchQueue.main.async { self?.feedTableView.reloadData() }
        break
      }
    }
  }
  
  private func loadCurrencyList() {
    NetworkManager.shared.getCurrencyList { [weak self] result in
       switch result {
         case .failure(let error):
             print(error.rawValue)
             break
         case .success(let response):
           DispatchQueue.main.async {
             self?.currencyList = response
             self?.currencyCollectiionView.reloadData()
           }
           break
       }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    [currencyCollectiionView, categoryCollectionView].forEach { [weak self] collectionView in
      guard let self = self else { return }
      collectionView!.delegate = self
      collectionView!.dataSource = self
    }
    
    loadPupolarArticles()
    loadCurrencyList()
  }
  
  override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.topItem?.title = self.title
  }
}

// MARK: Extentions
// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension FeedController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      if (collectionView == categoryCollectionView) {
          return categories.count
      }
      return currencyList.count
  }
  
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if collectionView == categoryCollectionView {
        if let cell = collectionView.cellForItem(at: indexPath) {
          currentCategory = categories[indexPath.row]
          cell.backgroundColor = .cyan
        }
      }
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      if let cell = collectionView.cellForItem(at: indexPath) {
        cell.backgroundColor = .none
      }
  }
}
// MARK: UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
          return CGSize(width: cell.label.frame.width + 50, height: cell.label.frame.height)
        }
        
        return CGSize(width: 80, height: collectionView.frame.height)
    }
}
