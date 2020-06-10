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
    
    override func viewDidLayoutSubviews() {
        if !scrollView.startUp {
            scrollView.setContentOffset(CGPoint(x: scrollView.totalStackViewWidth / 2, y: 0), animated: false)
            scrollView.startUp = true
        }
    }
    
    private func configure() {
        view.backgroundColor                            = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment                             = .center
        label.textColor                                 = .label
        label.text                                      = "Test"
        view.addSubview(label)
        scrollView                                      = SideScroller(startNumber: 100, endNumber: 200)
        scrollView.sideScrollDelegate                   = self
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            

            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            scrollView.heightAnchor.constraint(equalToConstant: 400),
            
            label.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension ViewController : SideScrollerDelegate {
    func valueIsUpdated(currentNumberSelection: Int) {
        label.text = "\(currentNumberSelection)" + " lbs"
    }
}

