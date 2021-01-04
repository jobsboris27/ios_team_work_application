//
//  SearchArticleResponse.swift
//  News
//
//  Created by Boris on 04.01.2021.
//

import Foundation

struct SearchArticleDocsItemMediaResponse: Codable {
  public var url: String
}

struct SearchArticleDocsItemResponse: Codable {
  public var webUrl: String
  public var snippet: String
  public var leadParagraph: String
  public var abstract: String
  public var source: String
  public var multimedia: [SearchArticleDocsItemMediaResponse]
}

struct SearchArticleDocsResponse: Codable {
  public var docs: [SearchArticleDocsItemResponse]
}

struct SearchArticleResponse: Codable {
  public var response: SearchArticleDocsResponse
}
