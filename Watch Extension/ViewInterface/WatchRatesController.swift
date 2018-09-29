//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import WatchKit
import Foundation


class WatchRatesController: WKInterfaceController {
    
    private enum Constants {
        static let rowType = "RateRow"
        
        enum Strings {
            static let errorTitle = "Oops"
            static let reloadButton = "Reload"
        }
    }

    @IBOutlet var todayLabel: WKInterfaceLabel!
    @IBOutlet var table: WKInterfaceTable!
    var presenter: RatesPresenterProtocol?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //Setup
        WatchRatesRouter.setupModule(with: self)
        
        presenter?.viewDidLoad()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension WatchRatesController: RatesViewInterface {
    
    func viewShouldUpdateHistorical(with viewModel: HistoricalRatesViewModel) {
        table.setNumberOfRows(viewModel.historialRates.count, withRowType: Constants.rowType)
        
        for index in 0..<table.numberOfRows {
            guard let controller = table.rowController(at: index) as? RateRowController else { continue }
            
            controller.rateViewModel = viewModel.historialRates[index]
        }
    }
    
    func viewShouldUpdateRealTime(with viewModel: RateViewModel) {
        todayLabel.setText("\(viewModel.stringDate): \(viewModel.stringValue)")
    }
    
    func showError(message: String) {
        let reload = WKAlertAction.init(title: Constants.Strings.reloadButton, style:.default) {
            self.presenter?.viewNeedsUpdatedData()
        }
        
        presentAlert(withTitle: Constants.Strings.errorTitle, message: message, preferredStyle:.actionSheet, actions: [reload])
    }
}
