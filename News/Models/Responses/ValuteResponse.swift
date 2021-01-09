//
//  ValuteResponse.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

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
