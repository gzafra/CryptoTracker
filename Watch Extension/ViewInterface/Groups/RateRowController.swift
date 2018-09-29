//
//  RateRowController.swift
//  Watch Extension
//
//  Created by Guillermo Zafra on 29/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import WatchKit

class RateRowController: NSObject {
    var rateViewModel: RateViewModel? {
        didSet{
            guard let rateViewModel = rateViewModel else { return }
            mainLabel.setText("\(rateViewModel.stringTitle): \(rateViewModel.stringRate)")
        }
    }
    @IBOutlet var mainLabel: WKInterfaceLabel!
}
