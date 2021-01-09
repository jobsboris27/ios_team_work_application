//
//  SearchController.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

import UIKit

class SearchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = self.title
    }

}
