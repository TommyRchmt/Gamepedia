//
//  NetworkConstant.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 08/11/21.
//

import Foundation

enum NetworkUrl: String {
    case rawgApiUrl = "https://api.rawg.io/api/games"
    case rawgApiKey = "af822c32d03145a9b2d6c0ad91aac780"
}

public enum RequestType {
    case firstLoad
    case nextLoad
}
