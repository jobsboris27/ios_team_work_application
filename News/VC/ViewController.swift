//
//  ViewController.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 02.01.2021.
//

import UIKit

struct News: Hashable {
    var name: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.id == rhs.id
    }
}

class ViewController: UIViewController {
    
    var currency = Currency.getCurrency()
    var category = Categories.getCategory()
    

    var collectionView: UICollectionView!
    
    enum Section: Int, CaseIterable {
        case currency, category
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, News>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        createDataSource()
        reloadData()
    }

    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 200), collectionViewLayout: createCompositionLayout())
        //collectionView.autoresizingMask = [.flexibleWidth]
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "currencyCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "categoriesCell")
    
    }
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, News>()
        snapshot.appendSections([.currency, .category])
        
        snapshot.appendItems(currency, toSection: .currency)
        snapshot.appendItems(category, toSection: .category)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

}

extension ViewController {
    
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, News>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, section) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind")
            }
            
            switch section {
            case .currency:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currencyCell", for: indexPath)
                cell.backgroundColor = .red
                return cell
            case .category:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
                cell.backgroundColor = .blue
                return cell
            }
        })
    }
    
    private func createCompositionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknown section kind")
            }
        
            switch section {
            case .currency:
                return self.createCurrency()
            case .category:
                return self.createCategory()
            }
        }
        return layout
    }
    
    private func createCurrency() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(60),
                                               heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    private func createCategory() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                               heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    
}


