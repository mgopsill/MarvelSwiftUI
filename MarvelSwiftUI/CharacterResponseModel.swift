//
//  CharacterResponseModel.swift
//  FordInterview
//
//  Created by Mike Gopsill on 21/01/2020.
//  Copyright © 2020 mgopsill. All rights reserved.
//

import Foundation

struct CharacterResponseModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let characters: [MarvelCharacter]
    
    enum CodingKeys: String, CodingKey {
        case characters = "results"
    }
}

struct MarvelCharacter: Codable {
    let id = UUID()
    let name, description: String
    let thumbnail: Thumbnail
    let urls: [MarvelURL]
}

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case jpg = "jpg"
}

struct MarvelURL: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

extension MarvelCharacter {
    var imageURL: URL {
        let urlString = String("\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
        return URL(string: urlString)!
    }
    
    var websiteURL: URL? {
        let websiteURL = urls.filter { $0.type == .detail }
        guard let urlString = websiteURL.first?.url else { return nil }
        return URL(string: urlString)
    }
}
