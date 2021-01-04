//
//  CurrencyResponse.swift
//  News
//
//  Created by Boris on 04.01.2021.
//

import Foundation

struct ValuteResponse: Codable {
  public var numCode: String
  public var charCode: String
  public var nominal: Int
  public var name: String
  public var value: Double
  public var previous: Double
  
  enum CodingKeys: String, CodingKey {
    case numCode = "NumCode"
    case charCode = "CharCode"
    case nominal = "Nominal"
    case name = "Name"
    case value = "Value"
    case previous = "Previous"
  }
}

struct CurrencyResponse: Codable {
  public var Valute: [String: ValuteResponse]
}
