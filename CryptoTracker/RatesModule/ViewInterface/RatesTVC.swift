//
//  RatesTVC.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class RatesTVC: UITableViewController {
    private let cellIdentifier = "HistoricalRateCell"
    var presenter: RatesPresenterProtocol?
    
    // MARK: - Layout
    private enum Layout {
        static let headerHeight: CGFloat = 58
    }
    
    // MARK: - Properties

    private var historicalViewModel: HistoricalRatesViewModel?
    
    // Header view that displays the real time rate
    private let headerTitle = UILabel()
    private lazy var headerView: UIView = {
        let view = UIView()
        headerTitle.textAlignment = .center
        headerTitle.text = "Loading..."
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: headerTitle.trailingAnchor).isActive = true
        headerTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()


    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.beginRefreshing()
        presenter?.viewDidLoad()
        
        refreshControl?.addTarget(self, action: #selector(RatesTVC.handleRefresh(refreshControl:)),
                                       for: UIControlEvents.valueChanged)
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.headerHeight
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return historicalViewModel?.numberOfSections ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalViewModel?.numberOfRows ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cellViewModel = historicalViewModel?.historialRates[indexPath.row] else { return cell }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = cellViewModel.stringTitle + "     -       " + cellViewModel.stringRate
        return cell
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        presenter?.viewNeedsUpdatedData()
    }

}

extension RatesTVC: RatesViewInterface {
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel) {
        refreshControl?.endRefreshing()
        self.historicalViewModel = viewModel
        tableView.reloadData()
    }
    
    func viewShouldUpdateRealTime(with viewModel: RateViewModel) {
        let newRealTimeValue = "\(viewModel.stringTitle) - \(viewModel.stringRate)"
        // Skip if value is the same
        guard let currentValue = self.headerTitle.text, newRealTimeValue != currentValue else { return }
        
        // Animate the change
        UIView.animate(withDuration: 0.1, animations: {
            self.headerView.backgroundColor = .yellow
            self.headerTitle.text = newRealTimeValue
        }) { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.headerView.backgroundColor = .white
            }) { _ in
                
            }
        }
    }
    
    func showError(message: String) {
        // TODO: Show error
    }
}
