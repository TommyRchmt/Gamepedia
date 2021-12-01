//
//  HomeRouter.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import Foundation
import UIKit

protocol HomeRouter {
    func navigateToDetailPage(_ caller: UIViewController, gameId: String)
    func navigateToAboutPage(_ caller: UIViewController)
}

class HomeWireframe: HomeRouter {
    func navigateToDetailPage(_ caller: UIViewController, gameId: String) {
        DetailWireframe.navigateToModule(caller, gameId: gameId)
    }
    
    func navigateToAboutPage(_ caller: UIViewController) {
        AboutWireframe.navigateToModule(caller)
    }
}
