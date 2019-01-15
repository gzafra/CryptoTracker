//
//  RatesRouter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

/**
 RatesRouter
 
 Setups the VIPER module to show Rates, returns the view controller
 */
class RatesRouter: RatesRouterProtocol {
    static func setupModule() -> RatesViewInterface {
        
        // Init
        let remoteInteractor = RatesRemoteInteractor()
        let presenter = RatesPresenter(remoteInteractor: remoteInteractor)
        let ratesTVC = RatesTVC(presenter: presenter)
        let localInteractor = RatesLocalInteractor()

        // Setup
        presenter.viewInterface = ratesTVC
        remoteInteractor.delegate = presenter
        presenter.remoteInteractor = remoteInteractor
        presenter.localInteractor = localInteractor
        
        return ratesTVC
    }
}
