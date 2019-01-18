//
//  RatesPresenter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

final class RatesPresenter: RatesPresenterProtocol {
  
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
            self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringTitle: RatesLocalizedResources.Strings.now,
                                                                             stringRate: CurrencyFormatter.format(rate: defaultCurrency.rate,
                                                                                                                  currencyCode: AppConstants.defaultCurrency )))
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
            self.viewInterface?.showError(message: RatesLocalizedResources.Strings.genericError)
        })
    }
    
    private func generateHistoricalRatesViewModel(for data: RatesHistoricalData) -> [RateViewModel] {
        return data.days.map{ key, value in
            return RateViewModel(stringTitle: key,
                                 stringRate: CurrencyFormatter.format(rate: value,
                                                                      currencyCode: AppConstants.defaultCurrency))
            }.sorted{
                $0.stringTitle > $1.stringTitle // Because it comes in a dictionary, we need to sort it by title (date)
        }
    }
}

extension RatesPresenter: RatesInteractorDelegate {
    func didUpdate(realTimeData: RatesRealTimeData) {
        self.localInteractor?.save(realTimeRate: realTimeData)
        guard let currency = realTimeData.defaultCurrency else { return }
        self.viewInterface?.viewShouldUpdateRealTime(with: RateViewModel(stringTitle: RatesLocalizedResources.Strings.now,
                                                                         stringRate: CurrencyFormatter.format(rate: currency.rate,
                                                                                                              currencyCode: AppConstants.defaultCurrency )))
    }
    
    
}
