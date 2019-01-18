//
//  LoadingView.swift
//
//  Created by Guillermo Zafra on 16/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

class LoadingView : UIView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNib()
    }
    
    private func loadNib() {
        if let subview = Bundle.main.loadNibNamed(
            "LoadingView",
            owner: self,
            options: nil)?.first as? UIView {
            addSubview(subview)
            subview.autoPinEdges(to: self)
        }
    }
    
    
}
