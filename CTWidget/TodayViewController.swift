//
//  TodayViewController.swift
//  CTWidget
//
//  Created by Guillermo Zafra on 30/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var priceLabel: UILabel!
    var interactor: RatesRemoteInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor = RatesRemoteInteractor()
        priceLabel.text = "--"
    }
    
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        interactor?.fetchRealTimeData(successBlock: { [weak self] (data) in
            guard let rate = data.usd?.rate, let symbol = data.usd?.symbol else { return }
            self?.priceLabel.text = CurrencyFormatter.format(rate: rate, currencySymbol: symbol.htmlDecoded )
        }, failureBlock: { [weak self] in
            self?.priceLabel.text = "--"
        })
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
