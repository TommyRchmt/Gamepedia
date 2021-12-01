//
//  AboutRouter.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 19/11/21.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

protocol AboutRouter {
    // Add this later if you want to navigate somewhere
}

class AboutWireframe: AboutRouter {
    static func navigateToModule(_ caller: UIViewController, animated: Bool = true) {
        let storyboard = SwinjectStoryboard.create(name: "About", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        caller.navigationItem.backButtonTitle = "back".localized()
        caller.navigationController?.pushViewController(viewController, animated: animated)
    }
}
