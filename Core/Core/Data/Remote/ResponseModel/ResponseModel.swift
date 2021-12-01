//
//  ResponseModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 01/11/21.
//

import Foundation

// MARK: - Game List Response -
public struct ResponseModel: Decodable {
    var count: Double
    var next: String
    var previous: String?
    var results: [Games]
}

public struct Games: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
}

// MARK: - Game Detail Response -
public struct GameDetailResponseModel: Decodable {
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let description: String
    let website: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case description
        case website
    }
}
