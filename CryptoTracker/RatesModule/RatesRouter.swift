//
//  RatesRouter.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class RatesRouter {
    static func setupModule() -> UIViewController {
        // Init
        let storyboard = UIStoryboard(name: "Rates", bundle: nil)
        let ratesTVC = storyboard.instantiateInitialViewController() as! RatesTVC
        let presenter = RatesPresenter()
        let remoteInteractor = RatesRemoteInteractor()
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
