//
//  RatesPresenter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

final class RatesPresenter: RatesPresenterProtocol {
  
    private enum Constants {
        static let defaultCurrencySymbol = "€"
        enum Strings {
            static let errorMessage = "Something went wrong..."
            static let nowTitle = "NOW"
        }
    }
    var remoteInteractor: RatesRemoteInteractorProtocol
    var localInteractor: RatesLocalInteractorProtocol?
    
    weak var viewInterface: RatesViewInterface?
    
    init(remoteInteractor: RatesRemoteInteractorProtocol) {
        self.remoteInteractor = remoteInteractor
    }
    
    func viewDidLoad() {
        // Try to retrieve cached data
        if let historical = localInteractor?.fetchLocalHistorical() {
            let viewModel = HistoricalRatesViewModel(historialRates: self.generateHistoricalRatesViewModel(for: historical))
            self.viewInterface?.viewShouldUpdateHistorical(with: viewModel)
        }
        if let realTime = localInteractor?.fetchLocalRealTimeRate(),
            let defaultCurrency = realTime.defaultCurrency {
            self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringTitle: Constants.Strings.nowTitle,
                                                                             stringRate: CurrencyFormatter.format(rate: defaultCurrency.rate,
                                                                                                                  currencySymbol: HtmlDecoder.decode(string: defaultCurrency.symbol) )))
        }
        
        // Retrieve remote data
        remoteInteractor.startRealTimeDataPolling()
        viewNeedsUpdatedData()
    }

    func viewNeedsUpdatedData() {
        remoteInteractor.fetchHistoricalData(successBlock: { (historicalData) in
            self.localInteractor?.save(historicalRates: historicalData)
            let viewModel = HistoricalRatesViewModel(historialRates: self.generateHistoricalRatesViewModel(for: historicalData))
            self.viewInterface?.viewShouldUpdateHistorical(with: viewModel)
        }, failureBlock: {
            self.viewInterface?.showError(message: Constants.Strings.errorMessage)
        })
    }
    
    private func generateHistoricalRatesViewModel(for data: RatesHistoricalData) -> [RateViewModel] {
        return data.days.map{ key, value in
            return RateViewModel(stringTitle: key,
                                 stringRate: CurrencyFormatter.format(rate: value,
                                                                      currencySymbol: Constants.defaultCurrencySymbol)) // TODO: Should be dynamic
            }.sorted{
                $0.stringTitle > $1.stringTitle // Because it comes in a dictionary, we need to sort it by title (date)
        }
    }
}

extension RatesPresenter: RatesInteractorDelegate {
    func didUpdate(realTimeData: RatesRealTimeData) {
        self.localInteractor?.save(realTimeRate: realTimeData)
        guard let currency = realTimeData.defaultCurrency else { return }
        self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringTitle: Constants.Strings.nowTitle,
                                                                         stringRate: CurrencyFormatter.format(rate: currency.rate,
                                                                                                              currencySymbol: HtmlDecoder.decode(string: currency.symbol) )))
    }
    
    
}
