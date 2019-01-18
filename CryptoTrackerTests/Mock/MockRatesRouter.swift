//
//  MockRatesRouter.swift
//  CryptoTrackerTests
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit
@testable import CryptoTracker

class MockRatesRouter: RatesRouterProtocol {
    static func setupModule() -> RatesViewInterface {
        fatalError("Not implemented")
    }
    
    static func setupModuleToTestHistorical() -> RatesViewInterface {
        let remoteInteractor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson))
        let presenter = RatesPresenter(remoteInteractor: remoteInteractor)
        let ratesTVC = RatesTVC(presenter: presenter)
        
        let localInteractor = RatesLocalInteractor()
        
        // Setup
        ratesTVC.presenter = presenter
        remoteInteractor.delegate = presenter
        presenter.localInteractor = localInteractor
        presenter.viewInterface = ratesTVC
        return ratesTVC
    }

    static func setupModuleToTestRealTime() -> RatesViewInterface {
        let remoteInteractor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.realTimeJson))
        let presenter = RatesPresenter(remoteInteractor: remoteInteractor)
        let ratesTVC = RatesTVC(presenter: presenter)
        
        let localInteractor = RatesLocalInteractor()
        
        // Setup
        ratesTVC.presenter = presenter
        remoteInteractor.delegate = presenter
        presenter.localInteractor = localInteractor
        presenter.viewInterface = ratesTVC
        return ratesTVC
    }
}
