//
//  File.swift
//  NewsApp
//
//  Created by Евгений Прохоров on 04.01.2021.
//

struct Categories: Hashable {
    var category: String
    
    var total: String {
        "\(category)"
    }
}

extension Categories {
    static func getCategory() -> [Categories] {
        return [
            Categories(category: "Popular"),
            Categories(category: "Automobiles"),
            Categories(category: "Insider"),
            Categories(category: "Politics"),
            Categories(category: "Science"),
            Categories(category: "Sports")
        ]
    }
}
