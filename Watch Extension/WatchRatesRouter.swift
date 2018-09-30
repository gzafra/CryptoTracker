//
//  WatchRatesRouter.swift
//  Watch Extension
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

/**
 WatchRatesRouter
 
 Setups the VIPER module to show Rates on watch companion, returns a WKInterfaceController
 */
class WatchRatesRouter {
    static func setupModule(with viewInterface: RatesViewInterface) {
        
        let ratesPresenter = RatesPresenter()
        let remoteInteractor = RatesRemoteInteractor()
        remoteInteractor.delegate = ratesPresenter
        ratesPresenter.remoteInteractor = remoteInteractor
        ratesPresenter.viewInterface = viewInterface
        viewInterface.presenter = ratesPresenter
    }
}
