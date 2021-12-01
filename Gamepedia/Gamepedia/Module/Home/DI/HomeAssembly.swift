//
//  HomeAssembly.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 03/11/21.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Core

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.register(HomeRouter.self) { _ in
            HomeWireframe()
        }
        
        container.register(HomeViewModel.self) { resolver in
            HomeViewModelImpl(useCase: resolver.resolve(GamepediaUseCase.self)!)
        }
        
        container.storyboardInitCompleted(HomeViewController.self) { (resolver, c) in
            c.viewModel = resolver.resolve(HomeViewModel.self)!
            c.router = resolver.resolve(HomeRouter.self)!
        }
        
    }
}
