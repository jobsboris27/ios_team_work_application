//
//  ArticlesByCategoryResult.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

struct ArticlesByCategoryResult: Codable {
    
    public var url: String
    public var publishedDate: String
    public var title: String
    public var abstract: String
    public var desFacet: [String]
    public var multimedia: [ArticlesByCategoryMedia]
    
}
