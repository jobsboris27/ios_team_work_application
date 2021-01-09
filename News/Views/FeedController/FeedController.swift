//
//  FeedController.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

class FeedController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            NetworkManager.shared.getCurrencyList { result in
              switch result {
              case .failure(let error):
                print(error.rawValue)
                break
              case .success(let response):
                print(response)
                break
              }
            }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = self.title
    
    }
}
