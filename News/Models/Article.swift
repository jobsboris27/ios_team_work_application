//
//  Article.swift
//  News
//
//  Created by Boris on 27.12.2020.
//

import Foundation

struct Article: Codable {
  let image: String
  let title: String
  let text: String
  let date: Date
  let url: String
}
