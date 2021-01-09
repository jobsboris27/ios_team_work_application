//
//  SearchArticleDocsItemResponse.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

struct SearchArticleDocsItemResponse: Codable {
    
    public var webUrl: String
    public var snippet: String
    public var leadParagraph: String
    public var abstract: String
    public var source: String
    public var multimedia: [SearchArticleDocsItemMediaResponse]
    
}
