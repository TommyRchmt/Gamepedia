//
//  GamepediaRepository.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation
import RxSwift

public protocol GamepediaRepository {
    // MARK: REMOTE
    func getGameList(requestType: RequestType, with urlForNextLoad: String) -> Observable<GameListModel>
    func getGameDetail(gameId: String) -> Observable<GameDetailModel>
    
    // MARK: LOCAL
    func getFavorite() -> Observable<[FavoriteModel]>
    func addFavorite(from favorite: FavoriteModel) -> Observable<Bool>
    func checkFavorite(of id: String) -> Observable<Bool>
    func deleteFavorite(of id: String) -> Observable<Bool>
}
