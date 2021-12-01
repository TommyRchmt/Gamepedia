//
//  GamepediaUseCaseTests.swift
//  GamepediaTests
//
//  Created by Tommy Rachmat on 20/11/21.
//

import XCTest
import RxSwift
@testable import Core

class GamepediaUseCaseTests: XCTestCase {
    
    var repository: GamepediaRepositoryMock!
    var sut: GamepediaUseCaseImpl!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        self.repository = GamepediaRepositoryMock()
        self.sut = GamepediaUseCaseImpl(repository: self.repository)
    }

    override func tearDownWithError() throws {
        weak var object = self.sut
        self.sut = nil
        XCTAssertNil(object)
    }
    
    func testGetGameList() throws {
        let gameListModel = GameListModel(count: "5", next: "", results: [])
        self.repository.getGameListStub = Observable.of(gameListModel)
        
        var gameListResult: GameListModel!
        let result = self.sut.getGameList(requestType: .firstLoad, with: "")
        result.subscribe(onNext: { result in
            gameListResult = result
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(gameListResult, gameListModel)
        XCTAssertEqual(self.repository.getGameListWasCalled, 1)
    }
    
    func testGetGameDetail() throws {
        let gameDetail = GameDetailModel(id: "1",
                                         name: "Grand Theft Auto V",
                                         released: "2018-02-01",
                                         backgroundImage: "Mock Url",
                                         rating: "4.09",
                                         description: "Mock Description",
                                         website: "https://www.rockstargames.com")
        self.repository.getGameDetailStub = Observable.of(gameDetail)
        
        var gameDetailResult: GameDetailModel!
        let result = self.sut.getGameDetail(gameId: "1")
        result.subscribe(onNext: { result in
            gameDetailResult = result
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(gameDetailResult, gameDetail)
        XCTAssertEqual(self.repository.getGameDetailWasCalled, 1)
    }
    
    func testGetFavorite() throws {
        let favorite = FavoriteModel(id: "1", name: "Grand Theft Auto V", released: "2018-02-01", backgroundImage: "Mock Url", rating: "4.09")
        self.repository.getFavoriteStub = Observable.of([favorite])
        
        var favoriteResult: [FavoriteModel]!
        let result = self.sut.getFavorite()
        result.subscribe(onNext: { result in
            favoriteResult = result
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(favoriteResult, [favorite])
        XCTAssertEqual(self.repository.getFavoriteWasCalled, 1)
    }
    
    func testAddFavorite() throws {
        var testState: Bool!
        self.repository.addFavoriteStub = Observable.of(true)
        
        let favorite = FavoriteModel(id: "1", name: "Grand Theft Auto V", released: "2018-02-01", backgroundImage: "Mock Url", rating: "4.09")
        let result = self.sut.addFavorite(from: favorite)
        result.subscribe(onNext: { state in
            testState = state
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(testState, true)
        XCTAssertEqual(self.repository.addFavoriteWasCalled, 1)
    }
    
    func testCheckFavorite() throws {
        var testState: Bool!
        self.repository.checkFavoriteStub = Observable.of(true)
        
        let result = self.sut.checkFavorite(of: "1")
        result.subscribe(onNext: { state in
            testState = state
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(testState, true)
        XCTAssertEqual(self.repository.checkFavoriteWasCalled, 1)
    }
    
    func testDeleteFavorite() throws {
        var testState: Bool!
        self.repository.deleteFavoriteStub = Observable.of(true)
        
        let result = self.sut.deleteFavorite(of: "1")
        result.subscribe(onNext: { state in
            testState = state
        }).disposed(by: self.disposeBag)
        
        XCTAssertEqual(testState, true)
        XCTAssertEqual(self.repository.deleteFavoriteWasCalled, 1)
    }

}
