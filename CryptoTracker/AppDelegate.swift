//
//  AppDelegate.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        presentInitialViewController()
        return true
    }
    
    func presentInitialViewController() {
        guard let initialVC = RatesRouter.setupModule() as? UIViewController else {
            assertionFailure("Could not load initial ViewController")
            return
        }
        window?.rootViewController = initialVC
        window?.makeKeyAndVisible()
    }


}

