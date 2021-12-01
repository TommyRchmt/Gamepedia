//
//  GameDetailModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import Foundation

public struct GameDetailModel: Equatable {
    public let id: String
    public let name: String
    public let released: String
    public let backgroundImage: String
    public let rating: String
    public let description: String
    public let website: String
    
    public init(id: String, name: String, released: String, backgroundImage: String, rating: String, description: String, website: String) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.description = description
        self.website = website
    }
}
