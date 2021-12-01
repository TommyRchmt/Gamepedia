//
//  OurGameTableViewCell.swift
//  OurGame
//
//  Created by Tommy on 21/08/21.
//

import UIKit
import Kingfisher
import Core

class GameListTableViewCell: UITableViewCell {

    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameReleasedDate: UILabel!
    @IBOutlet weak var gameRating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        gameImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
      gameImage.image = nil
    }
    
    func bind(gameModel: GameModel) {
        self.gameTitle.text = gameModel.name
        self.gameReleasedDate.text = "Released: \(gameModel.released)"
        self.gameRating.text = String(gameModel.rating)
        self.gameImage.kf.indicatorType = .activity
        self.gameImage.kf.setImage(with: URL(string: gameModel.backgroundImage))
    }
    
    func bind(favoriteModel: FavoriteModel) {
        self.gameTitle.text = favoriteModel.name
        self.gameReleasedDate.text = "Released: \(favoriteModel.released)"
        self.gameRating.text = String(favoriteModel.rating)
        self.gameImage.kf.indicatorType = .activity
        self.gameImage.kf.setImage(with: URL(string: favoriteModel.backgroundImage))
    }

}
