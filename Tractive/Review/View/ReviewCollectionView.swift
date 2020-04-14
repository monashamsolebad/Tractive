//
//  ReviewCollectionView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-09.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ReviewCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.tractiveBackgroudColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
