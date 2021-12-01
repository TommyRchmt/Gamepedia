//
//  AboutViewController.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 19/11/21.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "about".localized()
        setupCircularImage()
    }
    
    private func setupCircularImage() {
        image.layer.masksToBounds = true
        image.layer.cornerRadius = image.bounds.width / 2
    }

}
