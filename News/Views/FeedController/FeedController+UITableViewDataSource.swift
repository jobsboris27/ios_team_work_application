//
//  FeedController+UITableViewDataSource.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        let article = articles[indexPath.row]
        
        if let feedCell = cell as? FeedTableViewCell {
            feedCell.set(article: article, category: currentCategory)
            return feedCell
        }
        
        return cell
    }
    
}

