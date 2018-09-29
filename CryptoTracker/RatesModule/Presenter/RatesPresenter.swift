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
        static let defaultCurrencyCode = "USD"
        static let defaultCurrencySymbol = "$"
        enum Strings {
            static let errorMessage = "Something went wrong..."
            static let nowTitle = "NOW"
        }
    }
    var interactor: RatesInteractor?
    weak var viewInterface: RatesViewInterface?
    
    func viewDidLoad() {
        interactor?.startRealTimeDataPolling()
        viewNeedsUpdatedData()
    }
    
    func viewNeedsUpdatedData() {
        interactor?.fetchHistoricalData(successBlock: { (historicalData) in
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
        }
    }
}

extension RatesPresenter: RatesInteractorDelegate {
    func didUpdate(realTimeData: RatesRealTimeData) {
        guard let usdCurrency = realTimeData.currencies[Constants.defaultCurrencyCode] else { return }
        self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringTitle: Constants.Strings.nowTitle,
                                                                         stringRate: CurrencyFormatter.format(rate: usdCurrency.rate, currencySymbol: usdCurrency.symbol.htmlDecoded)) )
    }
    
    
}
