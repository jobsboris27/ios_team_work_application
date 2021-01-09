//
//  DetailController.swift
//  NewsApp
//
//  Created by Вера Ксенофонтова on 01.01.2021.
//

import UIKit

class DetailController: UIViewController {
    
    var feed: Feed?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = feed?.date
        titleLabel.text = feed?.articalTitle
        previewImage.image = feed?.preview
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
    }
    
}
