//
//  GamepediaUseCase.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation
import RxSwift

public protocol GamepediaUseCase {
    func getGameList(requestType: RequestType, with urlForNextLoad: String) -> Observable<GameListModel>
    func getGameDetail(gameId: String) -> Observable<GameDetailModel>
    func getFavorite() -> Observable<[FavoriteModel]>
    func addFavorite(from favorite: FavoriteModel) -> Observable<Bool>
    func checkFavorite(of id: String) -> Observable<Bool>
    func deleteFavorite(of id: String) -> Observable<Bool>
}

public class GamepediaUseCaseImpl: GamepediaUseCase {
    var repository: GamepediaRepository
    
    public init(repository: GamepediaRepository) {
        self.repository = repository
    }
    
    public func getGameList(requestType: RequestType, with urlForNextLoad: String) -> Observable<GameListModel> {
        return self.repository.getGameList(requestType: requestType, with: urlForNextLoad).map { $0 }
    }
    
    public func getGameDetail(gameId: String) -> Observable<GameDetailModel> {
        return self.repository.getGameDetail(gameId: gameId).map { $0 }
    }
    
    public func getFavorite() -> Observable<[FavoriteModel]> {
        return self.repository.getFavorite().map { $0 }
    }
    
    public func addFavorite(from favorite: FavoriteModel) -> Observable<Bool> {
        return self.repository.addFavorite(from: favorite).map { $0 }
    }
    
    public func checkFavorite(of id: String) -> Observable<Bool> {
        return self.repository.checkFavorite(of: id).map { $0 }
    }
    
    public func deleteFavorite(of id: String) -> Observable<Bool> {
        return self.repository.deleteFavorite(of: id).map { $0 }
    }
    
}
