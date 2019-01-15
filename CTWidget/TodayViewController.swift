//
//  TodayViewController.swift
//  CTWidget
//
//  Created by Guillermo Zafra on 30/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit
import NotificationCenter

/**
 Today extension widget to show current BTC value.
 
 Uses RatesRmoteIntactor without a presenter as no complex presenting logic is needed.
 
 */
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
            guard let rate = data.defaultCurrency?.rate, let symbol = data.defaultCurrency?.symbol else { return }
            self?.priceLabel.text = CurrencyFormatter.format(rate: rate, currencySymbol: HtmlDecoder.decode(string: symbol) )
        }, failureBlock: { [weak self] in
            self?.priceLabel.text = "--" // TODO: Should probably allow to retry manually
        })
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
