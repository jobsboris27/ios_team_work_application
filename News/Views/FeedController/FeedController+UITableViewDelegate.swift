//
//  FeedController+UITableViewDelegate.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FeedTableViewCell else { return }
        
        guard let date = cell.dateLabel.text else { return }
        guard let title = cell.feedLabel.text else { return }
        guard let image = cell.previewImage.image else { return }
        
        let feed = Feed(date: date, articalTitle: title, preview: image)
        performSegue(withIdentifier: "openFeedSegue", sender: feed)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
