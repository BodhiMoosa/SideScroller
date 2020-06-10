//
//  CollectionMethodVC.swift
//  SideScrollProject
//
//  Created by Tayler Moosa on 5/24/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CollectionMethodVC: UIViewController {
    
    var collectionView      : UICollectionView!
    var screenWidth         = UIScreen.main.bounds.width
    var lineWidth           = 1
    var numberOfLines       = 201
    var spacing : CGFloat   = 5
    var currentSelected     : CGFloat!
    var label               : UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    private func configure() {
        print(screenWidth)
        view.backgroundColor                                        = .systemBackground
        let layout                                                  = UICollectionViewFlowLayout()
        layout.scrollDirection                                      = .horizontal
        collectionView                                              = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate                                     = self
        collectionView.dataSource                                   = self
        collectionView.translatesAutoresizingMaskIntoConstraints    = false
        collectionView.backgroundColor                              = .systemBackground
        collectionView.showsHorizontalScrollIndicator               = false

        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseID)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 55),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        label                                           = UILabel()
        label.textAlignment                             = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
        
        
    }



}

extension CollectionMethodVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print((numberOfLines * lineWidth) + Int(spacing) + numberOfLines - 1)
        return numberOfLines + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell
        if indexPath.row == 0 || indexPath.row == numberOfLines + 1 {
            cell.backgroundColor = .clear
        } else {
            cell.backgroundColor = .systemGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 || indexPath.row == numberOfLines + 1 {
            return CGSize(width: (screenWidth / 2) - 2.5, height: 0)
        } else if (indexPath.row - 1) % 10 == 0 {
            return CGSize(width: lineWidth, height: 50)
        } else {
            return CGSize(width: lineWidth, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let current = (scrollView.contentOffset.x / (spacing + CGFloat(lineWidth))).rounded()

        if current == currentSelected  {
            return
        } else if  current < 0 {
            currentSelected = 0
            
        } else if current >= CGFloat(numberOfLines) {
            currentSelected = CGFloat(numberOfLines - 1)
        } else {
            currentSelected = current
        }
            
            let cells = collectionView.visibleCells as! [CollectionViewCell]
            for x in cells {
                x.backgroundColor = .systemGray
            }
            let cell = collectionView.cellForItem(at: (IndexPath(row: Int(currentSelected) + 1, section: 0))) as! CollectionViewCell
            cell.backgroundColor = .red
            label.text = String(describing: currentSelected!)
    }
    
}
