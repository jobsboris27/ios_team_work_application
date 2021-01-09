//
//  DetailController.swift
//  NewsApp
//
//  Created by Вера Ксенофонтова on 01.01.2021.
//

import UIKit
import WebKit

class DetailController: UIViewController {
    
    var feed: Feed?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = feed?.date
        titleLabel.text = feed?.articalTitle
        previewImage.image = UIImage(named: "default")

    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        
        webView.isHidden = false
        spinner.isHidden = false
        spinner.startAnimating()
        
        load { (success) -> Void in
            if (success) { spinner.stopAnimating() }
        }
        
    }
    
    func load (completion: (Bool) -> Void) {
        if let url = URL(string: "https://www.apple.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
//        while (webView.isLoading) {}
        
        completion (true)
    }
    
}
