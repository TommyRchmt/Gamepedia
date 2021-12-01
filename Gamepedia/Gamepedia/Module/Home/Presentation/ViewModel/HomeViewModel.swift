//
//  HomeViewModel.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation
import RxSwift
import RxRelay
import Common
import Core

protocol HomeViewModel {
    var viewState: BehaviorRelay<ViewState> { get set }
    
    var gameList: BehaviorRelay<GameListModel> { get }
    var favoriteList: BehaviorRelay<[FavoriteModel]> { get }
    
    func getGameList()
    func getNextGameList()
    func getFavoriteList()
}

class HomeViewModelImpl: HomeViewModel {
    let disposeBag: DisposeBag = DisposeBag()

    var viewState: BehaviorRelay<ViewState> = BehaviorRelay(value: UIViewState.normal)
    var gameList: BehaviorRelay<GameListModel> = BehaviorRelay(value: GameListModel(count: "", next: "", results: []))
    var favoriteList: BehaviorRelay<[FavoriteModel]> = BehaviorRelay(value: [])
    
    private let useCase: GamepediaUseCase
    private let scheduler: SchedulerType
    
    init(useCase: GamepediaUseCase, scheduler: SchedulerType = MainScheduler.instance) {
        self.useCase = useCase
        self.scheduler = scheduler
    }
    
    func getGameList() {
        self.viewState.accept(UIViewState.loading)
        self.useCase.getGameList(requestType: .firstLoad, with: "")
            .subscribe(onNext: { [weak self] gameList in
                guard let self = self else { return }
                self.gameList.accept(gameList)
                self.viewState.accept(UIViewState.normal)
                self.viewState.accept(HomeViewState.gameLoaded)
            }, onError: { [weak self] _ in
                self?.viewState.accept(UIViewState.normal)
                self?.viewState.accept(HomeViewState.firstLoadError)
            }).disposed(by: self.disposeBag)
    }
    
    func getNextGameList() {
        self.useCase.getGameList(requestType: .nextLoad, with: gameList.value.next)
            .subscribe(onNext: { [weak self] newGameList in
                guard let self = self else { return }
                let combinedGameList = self.combineAllGameList(newGameList: newGameList)
                self.gameList.accept(combinedGameList)
                self.viewState.accept(HomeViewState.gameLoaded)
            }, onError: { [weak self] _ in
                self?.viewState.accept(HomeViewState.nextLoadError)
            }).disposed(by: self.disposeBag)
    }
    
    func getFavoriteList() {
        self.viewState.accept(UIViewState.loading)
        self.useCase.getFavorite()
            .subscribe(onNext: { [weak self] favorite in
                guard let self = self else { return }
                self.favoriteList.accept(favorite)
                self.viewState.accept(UIViewState.normal)
                self.viewState.accept(HomeViewState.gameLoaded)
            }).disposed(by: self.disposeBag)
    }
    
    private func combineAllGameList(newGameList: GameListModel) -> GameListModel {
        var gameList: GameListModel = self.gameList.value
        gameList.count = newGameList.count
        gameList.next = newGameList.next
        gameList.previous = newGameList.previous
        gameList.results.append(contentsOf: newGameList.results)
        return gameList
    }
}
