//
//  Mapper.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation

class GamepediaMapper {
    
    static func mapGameListResponseToDomains(input gameResponseModel: ResponseModel) -> GameListModel {
        var gameModel: [GameModel] = []
        gameModel = gameResponseModel.results.map { game in
            GameModel(id: String(game.id),
                      slug: game.slug,
                      name: game.name,
                      released: game.released.convertDateFormat(),
                      backgroundImage: game.backgroundImage,
                      rating: game.rating.toString())
        }
        return GameListModel(
            count: gameResponseModel.count.toString(),
            next: gameResponseModel.next,
            previous: gameResponseModel.previous,
            results: gameModel)
        
    }
    
    static func mapGameDetailResponseToDomains(input gameDetailResponseModel: GameDetailResponseModel) -> GameDetailModel {
        return GameDetailModel(
            id: String(gameDetailResponseModel.id),
            name: gameDetailResponseModel.name,
            released: gameDetailResponseModel.released.convertDateFormat(),
            backgroundImage: gameDetailResponseModel.backgroundImage,
            rating: gameDetailResponseModel.rating.toString(),
            description: gameDetailResponseModel.description.removeHtmlTag(),
            website: gameDetailResponseModel.website)
    }
    
    static func mapFavoriteEntityToDomains(input favoriteEntity: [FavoriteEntity]) -> [FavoriteModel] {
        return favoriteEntity.map { result in
            return FavoriteModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating)
        }
    }
    
    static func mapFavoriteModelDomainToEntity(input favoriteModel: FavoriteModel) -> FavoriteEntity {
        let favoriteEntity = FavoriteEntity()
        favoriteEntity.id = favoriteModel.id
        favoriteEntity.name = favoriteModel.name
        favoriteEntity.released = favoriteModel.released
        favoriteEntity.backgroundImage = favoriteModel.backgroundImage
        favoriteEntity.rating = favoriteModel.rating
        return favoriteEntity
    }
}
