//
//  ViewController.swift
//  SideScrollProject
//
//  Created by Tayler Moosa on 5/22/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label       = UILabel()
    var scrollView  : SideScroller!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()


    }
    


    private func configure() {
        view.backgroundColor                            = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor                                 = .label
        label.text                                      = "Test"
        view.addSubview(label)
        scrollView                      = SideScroller(startNumber: 100, endNumber: 400)
        scrollView.sideScrollDelegate   = self
        valueIsUpdated(currentNumberSelection: 100) 
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
            
        ])
    }
}


extension ViewController : SideScrollerDelegate {
    func valueIsUpdated(currentNumberSelection: Int) {
        label.text = "\(currentNumberSelection)" + " lbs"
    }
}

