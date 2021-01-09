//
//  PopularMedia.swift
//  News
//
//  Created by Вера Ксенофонтова on 09.01.2021.
//

struct PopularMedia: Codable {
    
    public var mediaMetadata: [PopularMediaItem]
    
    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
    
}
