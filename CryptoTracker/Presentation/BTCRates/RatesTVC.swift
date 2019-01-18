//
//  RatesTVC.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class RatesTVC: UIViewController, LoadingViewController {
    var presenter: RatesPresenterProtocol
    
    // Outlets
    public var tableView = UITableView(frame: .zero, style: .grouped)
    var refreshControl = UIRefreshControl()
    var loadingView: LoadingView = LoadingView(frame: .zero)
    
    // MARK: - Layout
    private enum Layout {
        static let headerHeight: CGFloat = 58
    }
    
    // MARK: - Properties

    internal var historicalViewModel: HistoricalRatesViewModel?
    
    // Header view that displays the real time rate
    private let headerTitle = UILabel()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        headerTitle.textAlignment = .center
        headerTitle.text = RatesLocalizedResources.Strings.loading
        view.addSubview(headerTitle)
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: headerTitle.trailingAnchor).isActive = true
        headerTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    public init(presenter: RatesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func commonInit() {
        view.backgroundColor = .white
        title = RatesLocalizedResources.Strings.title
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(HistoricalRateCell.self, forCellReuseIdentifier: HistoricalRateCell.identifier)
        tableView.addSubview(refreshControl)
        view.addSubview(tableView)
        tableView.autoPinEdges(to: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(RatesTVC.handleRefresh(refreshControl:)),
                                       for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        beginLoading()
    }

    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        presenter.viewNeedsUpdatedData()
    }

}

extension RatesTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Layout.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension RatesTVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return historicalViewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicalViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricalRateCell.identifier, for: indexPath)
        
        guard let cellViewModel = historicalViewModel?.historialRates[indexPath.row] else { return cell }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = cellViewModel.stringTitle + "     -       " + cellViewModel.stringRate
        return cell
    }
}

extension RatesTVC: RatesViewInterface {
    
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel) {
        refreshControl.endRefreshing()
        endLoading()
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
        UIAlertController.show(title: RatesLocalizedResources.Strings.errorTitle, message: message, in: self)
    }
}
