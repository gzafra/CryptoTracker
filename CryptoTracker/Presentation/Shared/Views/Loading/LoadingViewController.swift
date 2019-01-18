//
//  LoadingViewController.swift
//
//  Created by Guillermo Zafra on 17/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

protocol LoadingViewController {
    var loadingView: LoadingView { get }
}

extension LoadingViewController where Self: UIViewController {
    func beginLoading() {
        view.addSubview(loadingView)
        loadingView.autoPinEdges(to: view)
        loadingView.activityIndicator.startAnimating()
        view.bringSubview(toFront: loadingView)
    }
    
    func endLoading() {
        loadingView.removeFromSuperview()
    }
}
