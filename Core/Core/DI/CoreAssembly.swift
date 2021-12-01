//
//  CoreAssembly.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 03/11/21.
//

import Foundation
import Swinject

public class CoreAssembly: Assembly {
    
    public init() {
        // init
    }
    
    public func assemble(container: Container) {
        container.register(RemoteDataSource.self) { _ in
            RemoteDataSourceImpl()
        }
        
        container.register(LocalDataSource.self) { _ in
            LocalDataSourceImpl()
        }
        
        container.register(GamepediaRepository.self) { resolver in
            GamepediaRepositoryImpl(
                remoteDataSource: resolver.resolve(RemoteDataSource.self)!,
                localDataSource: resolver.resolve(LocalDataSource.self)!)
        }
        
        container.register(GamepediaUseCase.self) { resolver in
            GamepediaUseCaseImpl(repository: resolver.resolve(GamepediaRepository.self)!)
        }
    }
}
