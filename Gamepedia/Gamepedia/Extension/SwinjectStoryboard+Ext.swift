//
//  SwinjectStoryboard+Ext.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 03/11/21.
//

import Foundation
import SwinjectStoryboard
import Swinject

extension SwinjectStoryboard {
    static func setup() {
        _ = Assembler([
            GamepediaAssembly()
        ], container: SwinjectStoryboard.defaultContainer)
    }
}
