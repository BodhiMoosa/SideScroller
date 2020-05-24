//
//  SideScroller.swift
//  SideScrollProject
//
//  Created by Tayler Moosa on 5/22/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

protocol SideScrollerDelegate : class {
    func valueIsUpdated(currentNumberSelection: Int)
    func setStartValue() -> Int
    func setEndValue() -> Int

    
}

class SideScroller: UIScrollView {
    weak var sideScrollDelegate : SideScrollerDelegate!
    var stackView               : UIStackView!
    var lineView                = UIView()
    var spacing                 : UIView!
    var screenWidth             : CGFloat!
    var screenHeight            : CGFloat!
    var distanceBetweenPoints   : CGFloat!
    var selectedNumber          : Int!
    let generator               = UISelectionFeedbackGenerator()
    var startNumber             : Int!
    var endNumber               : Int!
    var totalStackViewWidth     : CGFloat!
    var stackSpacing            : CGFloat!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(startNumber: Int, endNumber: Int, selectedNumber: Int) {
        self.startNumber    = startNumber
        self.endNumber      = endNumber
        self.selectedNumber = selectedNumber
        super.init(frame: .zero)
        configureStackView()
        configure()
        setContentOffset(CGPoint(x: selectedNumber, y: 0), animated: false)
        print(contentOffset)
    }
    
    private func configureStackView() {
        
        screenHeight                                        = UIScreen.main.bounds.height
        screenWidth                                         = UIScreen.main.bounds.width
        stackView                                           = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis                                      = .horizontal
        stackView.distribution                              = .equalSpacing
        stackView.alignment                                 = .center
        spacing                                             = UIView()
        startNumber                                         = (startNumber != nil) ? startNumber : 0
        endNumber                                           = (endNumber != nil) ? endNumber : 400
        selectedNumber                                      = (selectedNumber != nil) ? selectedNumber : 0
        spacing.widthAnchor.constraint(equalToConstant: (screenWidth / 2) - 4).isActive = true
        stackView.addArrangedSubview(spacing)
        for x in startNumber...endNumber {
            lineView = UIView()
            if x % 10 == 0 {
                lineView.heightAnchor.constraint(equalToConstant: screenHeight * 0.05).isActive = true
            } else {
                lineView.heightAnchor.constraint(equalToConstant: screenHeight * 0.03).isActive = true
            }
            lineView.widthAnchor.constraint(equalToConstant: 1).isActive = true
            lineView.backgroundColor = .systemGray
            stackView.addArrangedSubview(lineView)
        }
        spacing = UIView()
        spacing.widthAnchor.constraint(equalToConstant: (screenWidth / 2) - 4).isActive = true
        stackView.addArrangedSubview(spacing)
        stackView.arrangedSubviews[selectedNumber + 1].backgroundColor = .systemRed
    
        addSubview(stackView)

        
    }

    
    private func configure() {
        distanceBetweenPoints   = (2000 - screenWidth) / CGFloat(endNumber)
        stackSpacing            = screenWidth * 0.0096
        totalStackViewWidth     = (stackSpacing * CGFloat(endNumber)) + screenWidth
        
        delegate                                        = self
        alwaysBounceHorizontal                          = true
        translatesAutoresizingMaskIntoConstraints       = false
        backgroundColor                                 = .systemBackground
        
        NSLayoutConstraint.activate([
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        stackView.topAnchor.constraint(equalTo: self.topAnchor),
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        stackView.heightAnchor.constraint(equalToConstant: screenHeight * 0.75),
        stackView.widthAnchor.constraint(equalToConstant: totalStackViewWidth)
        ])
        
    }
    
    
}



extension SideScroller : UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y  = 0
        let currentNumber           = Int((scrollView.contentOffset.x / stackSpacing).rounded())
        if selectedNumber == currentNumber {
            return
        } else {
            selectedNumber = currentNumber < 0 ? 0 : currentNumber
            generator.selectionChanged()
            selectedNumber = (startNumber ... endNumber).clamp(selectedNumber)

        }
        for x in stackView.arrangedSubviews {
            x.backgroundColor = .systemGray
        }
        if selectedNumber <= startNumber {
            stackView.arrangedSubviews[1].backgroundColor = .systemRed
        } else if selectedNumber >= endNumber + 1 {
            stackView.arrangedSubviews[endNumber + 1].backgroundColor = .systemRed
        } else {
            stackView.arrangedSubviews[selectedNumber + 1].backgroundColor = .systemRed
        }
        sideScrollDelegate.valueIsUpdated(currentNumberSelection: selectedNumber)
        
    }
}

extension ClosedRange {
    func clamp(_ value : Bound) -> Bound {
        return self.lowerBound > value ? self.lowerBound
            : self.upperBound < value ? self.upperBound
            : value
    }
}
