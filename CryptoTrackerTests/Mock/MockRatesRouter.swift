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
        let ratesTVC = MockViewInterface()
        return ratesTVC
    }
    
    static func setupModuleToTestHistorical() -> RatesViewInterface {
        let ratesTVC = setupModule()
        
        let presenter = RatesPresenter()
        let remoteInteractor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.historicalJson))
        let localInteractor = RatesLocalInteractor()
        
        // Setup
        ratesTVC.presenter = presenter
        remoteInteractor.delegate = presenter
        presenter.remoteInteractor = remoteInteractor
        presenter.localInteractor = localInteractor
        presenter.viewInterface = ratesTVC
        return ratesTVC
    }

    static func setupModuleToTestRealTime() -> RatesViewInterface {
        let ratesTVC = setupModule()
        
        let presenter = RatesPresenter()
        let remoteInteractor = RatesRemoteInteractor(requestManager: MockRequestManager(promiseJson: MockRequestManagerPromises.realTimeJson))
        let localInteractor = RatesLocalInteractor()
        
        // Setup
        ratesTVC.presenter = presenter
        remoteInteractor.delegate = presenter
        presenter.remoteInteractor = remoteInteractor
        presenter.localInteractor = localInteractor
        presenter.viewInterface = ratesTVC
        return ratesTVC
    }
}
