//
//  WatchRatesRouter.swift
//  Watch Extension
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import Foundation

class WatchRatesRouter {
    static func setupModule(with viewInterface: RatesViewInterface) {
        
        let ratesPresenter = RatesPresenter()
        ratesPresenter.interactor = RatesInteractor()
        ratesPresenter.interactor?.delegate = ratesPresenter
        ratesPresenter.viewInterface = viewInterface
        viewInterface.presenter = ratesPresenter
    }
}
