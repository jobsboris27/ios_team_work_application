//
//  FeedTableViewCell.swift
//  NewsApp
//
//  Created by Вера Ксенофонтова on 03.01.2021.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var preview: UIImageView!
    @IBOutlet weak var categotyLabel: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
//
//        let view = UIView()
//        view.backgroundColor = .blue
//        UIView.animate(withDuration: 0.5,
//                           animations: { [weak self] in
//                            self?.selectedBackgroundView = view
//                            //super.setSelected(selected, animated: animated)
//                           })
    }
    
}
