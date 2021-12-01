//
//  GamepediaRepositoryMock.swift
//  GamepediaTests
//
//  Created by Tommy Rachmat on 20/11/21.
//

import Foundation
import RxSwift
@testable import Core

class GamepediaRepositoryMock: GamepediaRepository {
    var getGameListStub: Observable<GameListModel>!
    var getGameListWasCalled: Int = 0
    
    var getGameDetailStub: Observable<GameDetailModel>!
    var getGameDetailWasCalled: Int = 0
    
    var getFavoriteStub: Observable<[FavoriteModel]>!
    var getFavoriteWasCalled: Int = 0
    
    var addFavoriteStub: Observable<Bool>!
    var addFavoriteWasCalled: Int = 0
    
    var checkFavoriteStub: Observable<Bool>!
    var checkFavoriteWasCalled: Int = 0
    
    var deleteFavoriteStub: Observable<Bool>!
    var deleteFavoriteWasCalled: Int = 0
    
    func getGameList(requestType: RequestType, with urlForNextLoad: String) -> Observable<GameListModel> {
        self.getGameListWasCalled += 1
        return getGameListStub
    }
    
    func getGameDetail(gameId: String) -> Observable<GameDetailModel> {
        self.getGameDetailWasCalled += 1
        return getGameDetailStub
    }
    
    func getFavorite() -> Observable<[FavoriteModel]> {
        self.getFavoriteWasCalled += 1
        return getFavoriteStub
    }
    
    func addFavorite(from favorite: FavoriteModel) -> Observable<Bool> {
        self.addFavoriteWasCalled += 1
        return addFavoriteStub
    }
    
    func checkFavorite(of id: String) -> Observable<Bool> {
        self.checkFavoriteWasCalled += 1
        return checkFavoriteStub
    }
    
    func deleteFavorite(of id: String) -> Observable<Bool> {
        self.deleteFavoriteWasCalled += 1
        return deleteFavoriteStub
    }
    
}
