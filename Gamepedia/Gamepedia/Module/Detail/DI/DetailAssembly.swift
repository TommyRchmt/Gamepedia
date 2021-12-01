//
//  DetailAssembly.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Core

class DetailAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DetailRouter.self) { _ in
            DetailWireframe()
        }
        
        container.register(DetailViewModel.self) { resolver in
            DetailViewModelImpl(useCase: resolver.resolve(GamepediaUseCase.self)!)
        }
        
        container.storyboardInitCompleted(DetailViewController.self) { (resolver, c) in
            c.viewModel = resolver.resolve(DetailViewModel.self)!
            c.router = resolver.resolve(DetailRouter.self)!
        }
    }
    
}
