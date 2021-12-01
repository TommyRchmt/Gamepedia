//
//  DetailViewController.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 17/11/21.
//

import UIKit
import RxSwift
import Common
import Core

class DetailViewController: UIViewController {

    @IBOutlet weak var gameDetailImageView: UIImageView!
    @IBOutlet weak var gameDetailTitle: UILabel!
    @IBOutlet weak var gameDetailReleased: UILabel!
    @IBOutlet weak var gameDetailRating: UILabel!
    @IBOutlet weak var gameDetailWebsite: UILabel!
    @IBOutlet weak var gameDetailDescription: UITextView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    var viewModel: DetailViewModel?
    var router: DetailRouter?
    
    var gameId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialContent()
        setupDetailPageNavigationBar()
        setupObserver()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.getGameDetail(gameId: self.gameId ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        configureNavigationBar(largeTitleColor: .white,
                               backgroundColor: #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1),
                               tintColor: .white,
                               title: "gamepedia_title".localized(),
                               preferredLargeTitle: true)
    }
    
    private func setupObserver() {
        self.viewModel?.viewState.subscribe(onNext: { [weak self] viewState in
            self?.handleViewState(viewState: viewState)
        }).disposed(by: self.disposeBag)
        
        self.viewModel?.gameDetail
            .subscribe(onNext: { [weak self] gameDetail in
                self?.setContent(of: gameDetail)
                self?.getFavoriteStatus()
            }).disposed(by: self.disposeBag)
        
        self.viewModel?.isFavorite
            .subscribe(onNext: { [weak self] favorite in
                self?.setFavoriteButton(isFavorite: favorite)
            }).disposed(by: self.disposeBag)
    }
    
    private func handleViewState(viewState: ViewState) {
        if let uiViewState = viewState as? UIViewState {
            switch uiViewState {
            case .normal:
                self.removeLoading()
            case .loading:
                self.showLoading()
                self.navigationItem.rightBarButtonItem = nil
            }
        }
        
        guard let detailViewState = viewState as? DetailViewState else { return }
        switch detailViewState {
        case .loadFail:
            self.showAlertErrorGettingDetail()
        }
    }
    
    private func getFavoriteStatus() {
        self.viewModel?.checkFavorite(of: self.gameId ?? "")
    }
    
    private func setFavoriteButton(isFavorite: Bool) {
        let favoriteButton = UIBarButtonItem(image: UIImage(named: "HeartRed"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(favoriteTapped))
        self.navigationItem.rightBarButtonItem  = favoriteButton
        if isFavorite {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
        } else {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray.withAlphaComponent(0.75)
        }
    }
    
    @objc private func favoriteTapped() {
        guard let isFavorite = self.viewModel?.isFavorite.value else { return }
        self.viewModel?.isFavorite.accept(!isFavorite)
        if !isFavorite {
            self.viewModel?.addFavorite()
        } else {
            self.viewModel?.deleteFavorite(of: self.gameId ?? "")
        }
    }
    
    private func setupDetailPageNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear
        navigationBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setInitialContent() {
        self.gameDetailTitle.text = ""
        self.gameDetailReleased.text = ""
        self.gameDetailRating.text = ""
        self.gameDetailDescription.text = ""
        self.gameDetailWebsite.text = ""
    }
    
    private func setContent(of gameDetail: GameDetailModel) {
        self.gameDetailImageView.kf.indicatorType = .activity
        self.gameDetailImageView.kf.setImage(with: URL(string: gameDetail.backgroundImage))
        self.gameDetailTitle.text = gameDetail.name
        self.gameDetailReleased.text = "Released: \(gameDetail.released)"
        self.gameDetailRating.text = String(gameDetail.rating)
        self.gameDetailDescription.text = gameDetail.description
        self.gameDetailWebsite.text = gameDetail.website
    }
    
    private func showAlertErrorGettingDetail() {
        let alert = UIAlertController(title: "error".localized(),
                                      message: "fetching_data_error_description".localized(),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "retry".localized(), style: UIAlertAction.Style.default, handler: { _ in
            self.viewModel?.getGameDetail(gameId: self.gameId ?? "")
        }))
        alert.addAction(UIAlertAction(title: "back".localized(), style: UIAlertAction.Style.default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.view.tintColor = #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }

}
