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
    internal let categories = ["Popular", "Sports", "Insider", "Auto", "Science"]
    internal var currencyList: [Currency] = []
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "openFeedSegue" else { return }
        guard let destiantion = segue.destination as? DetailController else { return }
        destiantion.feed = sender as? Feed
    }
    
}
