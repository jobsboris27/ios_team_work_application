//
//  NetworkManagerError.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

enum NetworkManagerError: String, Error {
    case somethingWentWrong = "Sorry, something went wrong"
    case unauthorized = "Invalid authorization, please check api key"
    case tooManyRequests = "Too many requests. You reached your per minute or per day rate limit."
}
