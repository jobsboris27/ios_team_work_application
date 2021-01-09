//
//  PopularArticleResult.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

struct PopularArticleResult: Codable {
    
    public var url: String
    public var publishedDate: String
    public var title: String
    public var abstract: String
    public var adxKeywords: String
    public var media: [PopularMedia]
    
}
