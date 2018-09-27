//
//  RatesPresenter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

final class RatesPresenter: RatesPresenterProtocol {
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
            self.viewInterface?.showError(message: "Something went wrong...")
        })
    }
    
    private func generateHistoricalRatesViewModel(for data: RatesHistoricalData) -> [RateViewModel] {
        return data.days.map{ key, value in
            return RateViewModel(stringDate: key,
                                           stringValue: CurrencyFormatter.format(rate: value,
                                                                                 currencySymbol: "$")) // TODO: Should be dynamic
        }
    }
}

extension RatesPresenter: RatesInteractorDelegate {
    func didUpdate(realTimeData: RatesRealTimeData) {
        guard let usdCurrency = realTimeData.currencies["USD"] else { return }
        self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringDate: "TODAY",
                                                                         stringValue: CurrencyFormatter.format(rate: usdCurrency.rate, currencySymbol: usdCurrency.symbol.htmlDecoded)) )
    }
    
    
}
