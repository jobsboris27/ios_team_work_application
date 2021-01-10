//
//  DetailController.swift
//  NewsApp
//
//  Created by Вера Ксенофонтова on 01.01.2021.
//

import UIKit
import WebKit

class DetailController: UIViewController {
    
    var article: Article?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
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
    
    private func load(completion: (Bool) -> Void) {
        if let url = URL(string: article!.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
//        while (webView.isLoading) {}
        
        completion (true)
    }
    
    
    private func configure() {
      if let article = article {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy"
        
        dateLabel.text = dateformat.string(from: article.date)
        previewImage.image = UIImage(named: "default")
        
        textLabel.text = article.text
        
        if (article.image != "default") {
            NetworkManager.shared.downloadImage(from: article.image) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async { self.previewImage.image = image }
            }
        }
      }
    }
}
