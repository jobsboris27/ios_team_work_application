//
//  FeedTableViewCell.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func set(article: Article, category: String) {
        previewImage.image = UIImage(named: "default")
        
        categoryLabel.text = category
        feedLabel.text = article.title
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy"
        dateLabel.text = dateformat.string(from: article.date)
        
        if (article.image != "default") {
            NetworkManager.shared.downloadImage(from: article.image) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async { self.previewImage.image = image }
            }
        }
    }
    
}
