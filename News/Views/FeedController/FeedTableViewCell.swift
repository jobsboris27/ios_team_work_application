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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
