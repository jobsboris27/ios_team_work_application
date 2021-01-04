//
//  PopularArticlesResponses.swift
//  News
//
//  Created by Boris on 03.01.2021.
//

import Foundation
import UIKit

struct PopularMediaItem: Codable {
  public var url: String
  public var format: String
  public var height: Int
  public var width: Int
}

struct PopularMedia: Codable {
  public var mediaMetadata: [PopularMediaItem]
  
  enum CodingKeys: String, CodingKey {
    case mediaMetadata = "media-metadata"
  }
}

struct PopularArticleResult: Codable {
  public var url: String
  public var publishedDate: String
  public var title: String
  public var abstract: String
  public var adxKeywords: String
  public var media: [PopularMedia]
}

struct PopularArticlesResponse: Codable {
  public var results: [PopularArticleResult]
}
