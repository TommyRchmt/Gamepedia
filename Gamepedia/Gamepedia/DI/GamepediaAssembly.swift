//
//  GamepediaAssembly.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 03/11/21.
//

import Foundation
import Swinject
import Core

class GamepediaAssembly: Assembly {
    func assemble(container: Container) {
        _ = Assembler([
            CoreAssembly(),
            HomeAssembly(),
            DetailAssembly()
        ], container: container)
    }
}
