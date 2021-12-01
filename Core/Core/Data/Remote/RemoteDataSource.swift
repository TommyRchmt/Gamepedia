//
//  RemoteDataSource.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 02/11/21.
//

import Foundation
import Alamofire
import RxSwift

public protocol RemoteDataSource {
    func getGameList(requestType: RequestType,
                     with urlForNextLoad: String) -> Observable<ResponseModel>
    func getGameDetail(gameId: String) -> Observable<GameDetailResponseModel>
}

public class RemoteDataSourceImpl: RemoteDataSource {
    public func getGameList(requestType: RequestType,
                     with urlForNextLoad: String) -> Observable<ResponseModel> {
        return Observable<ResponseModel>.create { observer in
            var request: DataRequest?
            if requestType == .firstLoad {
                let url = URL(string: NetworkUrl.rawgApiUrl.rawValue)!
                request = AF.request(url, parameters: ["key": NetworkUrl.rawgApiKey.rawValue])
            } else {
                request = AF.request(urlForNextLoad)
            }
            request?
                .validate()
                .responseDecodable(of: ResponseModel.self) { response in
                    switch response.result {
                    case .failure(_):
                        observer.onError(URLError.invalidResponse)
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    }
                }
            
            return Disposables.create()
        }
    }
    
    public func getGameDetail(gameId: String) -> Observable<GameDetailResponseModel> {
        return Observable<GameDetailResponseModel>.create { observer in
            let url = URL(string: NetworkUrl.rawgApiUrl.rawValue + "/\(gameId)")!
            AF.request(url, parameters: ["key": NetworkUrl.rawgApiKey.rawValue])
                .validate()
                .responseDecodable(of: GameDetailResponseModel.self) { response in
                    switch response.result {
                    case .failure(_):
                        observer.onError(URLError.invalidResponse)
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    }
                }
            return Disposables.create()
        }
    }
}
