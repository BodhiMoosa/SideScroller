//
//  ViewController.swift
//  SideScrollProject
//
//  Created by Tayler Moosa on 5/22/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label = UILabel()
    var scrollView : SideScroller!
    var button = UIButton()

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
        scrollView = SideScroller()
        scrollView.sideScrollDelegate = self

        view.addSubview(scrollView)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("test", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)

        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    @objc private func buttonTap() {
        scrollView.setContentOffset(CGPoint(x: 30, y: 0), animated: true)
    }
}



extension ViewController : SideScrollerDelegate {
    func setStartValue() -> Int {
        return 10
    }
    
    func setEndValue() -> Int {
        return 100
    }
    
    
    func valueIsUpdated(currentNumberSelection: Int) {
        label.text = String(currentNumberSelection) + "lbs"
    }
    

}

