//
//  CollectionViewCell.swift
//  SideScrollProject
//
//  Created by Tayler Moosa on 5/24/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemGray
    }
    
}
