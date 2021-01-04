//
//  ArticlesByCategoryResponse.swift
//  News
//
//  Created by Boris on 03.01.2021.
//

import Foundation
import UIKit

struct ArticlesByCategoryMedia: Codable {
  public var url: String
}

struct ArticlesByCategoryResult: Codable {
  public var url: String
  public var publishedDate: String
  public var title: String
  public var abstract: String
  public var desFacet: [String]
  public var multimedia: [ArticlesByCategoryMedia]
}

struct ArticlesByCategoryResponse: Codable {
  public var results: [ArticlesByCategoryResult]
}
