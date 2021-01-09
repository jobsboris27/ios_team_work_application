//
//  FeedController+UITableViewDelegate.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

extension FeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "openFeedSegue", sender: articles[indexPath.row])

        tableView.deselectRow(at: indexPath, animated: true)
    }    
}
