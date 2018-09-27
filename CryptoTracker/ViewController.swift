//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var realTimeRequest = CoinDeskRealTimeRequest()
        realTimeRequest.completion = { result in
            switch result {
            case .success(let data):
                print(data.debugDescription)
            case .failure(let error):
                break
            }
        }
        
        RequestManager().send(request: realTimeRequest)
    }


}

