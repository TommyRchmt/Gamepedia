//
//  GamepediaRepositoryImpl.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation
import RxSwift

public class GamepediaRepositoryImpl: GamepediaRepository {
    
    fileprivate let remoteDataSource: RemoteDataSource
    fileprivate let localDataSource: LocalDataSource
    
    public init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    public func getGameList(requestType: RequestType, with urlForNextLoad: String) -> Observable<GameListModel> {
        return self.remoteDataSource.getGameList(requestType: requestType, with: urlForNextLoad)
            .map { GamepediaMapper.mapGameListResponseToDomains(input: $0) }
    }
    
    public func getGameDetail(gameId: String) -> Observable<GameDetailModel> {
        return self.remoteDataSource.getGameDetail(gameId: gameId)
            .map { GamepediaMapper.mapGameDetailResponseToDomains(input: $0) }
    }
    
    public func getFavorite() -> Observable<[FavoriteModel]> {
        return self.localDataSource.getFavorite()
            .map { GamepediaMapper.mapFavoriteEntityToDomains(input: $0) }
    }
    
    public func addFavorite(from favorite: FavoriteModel) -> Observable<Bool> {
        let favoriteEntity = GamepediaMapper.mapFavoriteModelDomainToEntity(input: favorite)
        return self.localDataSource.addFavorite(from: favoriteEntity).map { $0 }
    }
    
    public func checkFavorite(of id: String) -> Observable<Bool> {
        return self.localDataSource.checkFavorite(of: id).map { $0 }
    }
    
    public func deleteFavorite(of id: String) -> Observable<Bool> {
        return self.localDataSource.deleteFavorite(of: id).map { $0 }
    }
    
}
