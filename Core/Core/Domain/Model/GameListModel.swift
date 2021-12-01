//
//  GameListModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation

public struct GameListModel: Equatable {
    public var count: String
    public var next: String
    public var previous: String?
    public var results: [GameModel]
    
    public init(count: String, next: String, previous: String? = nil, results: [GameModel]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

public struct GameModel: Equatable {
    public let id: String
    public let slug: String
    public let name: String
    public let released: String
    public let backgroundImage: String
    public let rating: String
    
}
