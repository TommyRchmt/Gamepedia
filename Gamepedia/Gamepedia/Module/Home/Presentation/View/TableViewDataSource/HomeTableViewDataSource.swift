//
//  HomeTableViewDataSource.swift
//  Gamepedia
//
//  Created by Tommy Rachmat on 08/11/21.
//

import Foundation
import UIKit
import Kingfisher
import Common

class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var caller: HomeViewController?
    
    func registerDataSource(_ caller: HomeViewController, tableView: UITableView) {
        self.caller = caller
        
        tableView.register(UINib(nibName: "GameListTableViewCell", bundle: nil), forCellReuseIdentifier: "GameListCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = caller?.viewModel else { return 0 }
        switch self.caller?.segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.gameList.value.results.count
        case 1:
            if viewModel.favoriteList.value.isEmpty {
                tableView.setEmptyMessage("no_favorite_description".localized())
            } else {
                tableView.restore()
            }
            return viewModel.favoriteList.value.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = caller?.viewModel else { return UITableViewCell() }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GameListCell", for: indexPath) as? GameListTableViewCell {
            switch self.caller?.segmentedControl.selectedSegmentIndex {
            case 0:
                let gameModel = viewModel.gameList.value.results[indexPath.row]
                cell.bind(gameModel: gameModel)
            case 1:
                let favoriteModel = viewModel.favoriteList.value[indexPath.row]
                cell.bind(favoriteModel: favoriteModel)
            default: break
            }
            let selectedView = UIView()
            selectedView.backgroundColor = .clear
            cell.selectedBackgroundView = selectedView
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = caller?.viewModel else { return }
        switch self.caller?.segmentedControl.selectedSegmentIndex {
        case 0:
            let gameModel = viewModel.gameList.value.results[indexPath.row]
            self.caller?.navigateToDetailPage(gameId: gameModel.id)
        case 1:
            let favoriteModel = viewModel.favoriteList.value[indexPath.row]
            self.caller?.navigateToDetailPage(gameId: favoriteModel.id)
        default: break
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let spinner = UIActivityIndicatorView(style: .medium)
        
        switch self.caller?.segmentedControl.selectedSegmentIndex {
        case 0:
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                caller?.tableView.tableFooterView = spinner
                caller?.tableView.tableFooterView?.isHidden = false
                self.caller?.getNextGameList()
            }
        case 1:
            tableView.tableFooterView?.isHidden = true
        default: break
        }
        
    }
}
