//
//  FeedController+UITableViewDataSource.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
            
            if let feedCell = cell as? FeedTableViewCell {
                feedCell.feedLabel.text = "index \(indexPath)"
                feedCell.previewImage.image = UIImage(named: "default")
                feedCell.dateLabel.text = "date"
                return feedCell
            }
            
            return cell
    }
}
