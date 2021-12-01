//
//  DetailRouter.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

protocol DetailRouter {
    // Add this later if you want to navigate somewhere
}

class DetailWireframe: DetailRouter {
    static func navigateToModule(_ caller: UIViewController, gameId: String, animated: Bool = true) {
        let storyboard = SwinjectStoryboard.create(name: "Detail", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.gameId = gameId
        caller.navigationItem.backButtonTitle = ""
        caller.navigationController?.pushViewController(viewController, animated: animated)
    }
}
