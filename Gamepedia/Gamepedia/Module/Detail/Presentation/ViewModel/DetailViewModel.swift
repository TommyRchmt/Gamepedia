//
//  DetailViewModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import Foundation
import RxSwift
import RxRelay
import Common
import Core

protocol DetailViewModel {
    var viewState: BehaviorRelay<ViewState> { get set }
    var gameDetail: BehaviorRelay<GameDetailModel> { get }
    
    var isFavorite: BehaviorRelay<Bool> { get }
    
    func getGameDetail(gameId: String)
    func addFavorite()
    func checkFavorite(of id: String)
    func deleteFavorite(of id: String)
}

class DetailViewModelImpl: DetailViewModel {
    let disposeBag: DisposeBag = DisposeBag()

    var viewState: BehaviorRelay<ViewState> = BehaviorRelay(value: UIViewState.normal)
    var gameDetail: BehaviorRelay<GameDetailModel> = BehaviorRelay(value: GameDetailModel(id: "",
                                                                                          name: "",
                                                                                          released: "",
                                                                                          backgroundImage: "",
                                                                                          rating: "",
                                                                                          description: "",
                                                                                          website: ""))
    var isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private let useCase: GamepediaUseCase
    private let scheduler: SchedulerType
    
    init(useCase: GamepediaUseCase, scheduler: SchedulerType = MainScheduler.instance) {
        self.useCase = useCase
        self.scheduler = scheduler
    }
    
    func getGameDetail(gameId: String) {
        self.viewState.accept(UIViewState.loading)
        self.useCase.getGameDetail(gameId: gameId)
            .subscribe(onNext: { [weak self] gameDetail in
                self?.gameDetail.accept(gameDetail)
                self?.viewState.accept(UIViewState.normal)
            }, onError: { [weak self] _ in
                self?.viewState.accept(UIViewState.normal)
                self?.viewState.accept(DetailViewState.loadFail)
            }).disposed(by: self.disposeBag)
    }
    
    func addFavorite() {
        let favoriteModel = FavoriteModel(
            id: gameDetail.value.id,
            name: gameDetail.value.name,
            released: gameDetail.value.released,
            backgroundImage: gameDetail.value.backgroundImage,
            rating: gameDetail.value.rating)
        self.useCase.addFavorite(from: favoriteModel)
            .subscribe()
            .disposed(by: self.disposeBag)
    }
    
    func checkFavorite(of id: String) {
        self.useCase.checkFavorite(of: id)
            .subscribe(onNext: { [weak self] favorite in
                self?.isFavorite.accept(favorite)
            }).disposed(by: self.disposeBag)
    }
    
    func deleteFavorite(of id: String) {
        self.useCase.deleteFavorite(of: id)
            .subscribe()
            .disposed(by: self.disposeBag)
    }
}
