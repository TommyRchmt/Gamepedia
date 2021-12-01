//
//  FavoriteModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 18/11/21.
//

import Foundation

public struct FavoriteModel: Equatable {
    public let id: String
    public let name: String
    public let released: String
    public let backgroundImage: String
    public let rating: String
    
    public init(id: String, name: String, released: String, backgroundImage: String, rating: String) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}
