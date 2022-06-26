//
//  ViewController.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 31/10/21.
//

import UIKit
import RxSwift
import Common

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tableViewDataSource: HomeTableViewDataSource!
    var segmentedControl: UISegmentedControl!
    
    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: HomeViewModel?
    var router: HomeRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setupSegmentedControl()
        self.setupObserver()
        self.tableViewDataSource.registerDataSource(self, tableView: self.tableView)
        self.viewModel?.getGameList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if segmentedControl.selectedSegmentIndex == 1 {
            self.viewModel?.getFavoriteList()
        }
    }
    
    private func setupObserver() {
        self.viewModel?.viewState.subscribe(onNext: { [weak self] viewState in
            self?.handleViewState(viewState: viewState)
        }).disposed(by: self.disposeBag)
    }

    private func handleViewState(viewState: ViewState) {
        if let uiViewState = viewState as? UIViewState {
            switch uiViewState {
            case .normal:
                self.removeLoading()
            case .loading:
                self.showLoading()
            }
        }
        
        guard let homeViewState = viewState as? HomeViewState else { return }
        switch homeViewState {
        case .gameLoaded:
            self.tableView.reloadData()
        case .firstLoadError:
            self.showAlertErrorGettingFirstData()
        case .nextLoadError:
            self.showAlertErrorGettingNextData()
        }
    }
    
    func getNextGameList() {
        self.viewModel?.getNextGameList()
    }
    
    func navigateToDetailPage(gameId: String) {
        self.router?.navigateToDetailPage(self, gameId: gameId)
    }
    
    @IBAction func aboutButtonTapped(_ sender: Any) {
        self.router?.navigateToAboutPage(self)
    }
}

extension HomeViewController {
    private func setNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgroundColor: #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1),
                               tintColor: .white,
                               title: "gamepedia_title".localized(),
                               preferredLargeTitle: true)
    }
    
    private func setupSegmentedControl() {
        let allTitle = "all_title".localized()
        let favoriteTitle = "favorite_title".localized()
        let titles = [allTitle, favoriteTitle]
        segmentedControl = UISegmentedControl(items: titles)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1)], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .normal)
        segmentedControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.sizeToFit()
        segmentedControl.addTarget(self, action: #selector(segmentChangedAction), for: .valueChanged)
        segmentedControl.sendActions(for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }
    
    @objc private func segmentChangedAction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case 1:
            self.viewModel?.getFavoriteList()
        default:
            break
        }
    }
    
    private func showAlertErrorGettingFirstData() {
        let alert = UIAlertController(title: "error".localized(),
                                      message: "fetching_data_error_description".localized(),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "retry".localized(), style: UIAlertAction.Style.default, handler: { _ in
            guard let viewModel = self.viewModel else { return }
            if viewModel.gameList.value.results.isEmpty {
                viewModel.getGameList()
            }
        }))
        alert.view.tintColor = #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }

    private func showAlertErrorGettingNextData() {
        let alert = UIAlertController(title: "error".localized(),
                                      message: "failed_getting_data_description".localized(),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok".localized(), style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = #colorLiteral(red: 0.2, green: 0.2196078431, blue: 0.3843137255, alpha: 1)
        self.present(alert, animated: true, completion: nil)
    }
}
