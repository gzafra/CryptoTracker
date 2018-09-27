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
        let interactor = RatesInteractor()
        
        // Setup
        ratesTVC.presenter = presenter
        interactor.delegate = presenter
        presenter.interactor = interactor
        presenter.viewInterface = ratesTVC
        
        return ratesTVC
    }
}
