//
//  SearchController+UITableViewDataSource.swift
//  News
//
//  Created by Вера Ксенофонтова on 07.01.2021.
//

import UIKit

extension SearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
        cell.textLabel?.text = "index \(indexPath)"
        return cell
    }
    
}
