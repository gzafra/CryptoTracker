//
//  HistorialRateCell.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 27/09/2018.
//  Copyright © 2018 Guillermo Zafra. All rights reserved.
//

import UIKit

class HistoricalRateCell: UITableViewCell {
    static var identifier : String = {
        return String(describing: self)
    }()
    
    var titleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private enum Layout {
        static let horizontalPadding: CGFloat = 12
    }

    private func setupViews() {
        
        // titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        
        // Constraints
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.horizontalPadding).isActive = true
        trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Layout.horizontalPadding).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
