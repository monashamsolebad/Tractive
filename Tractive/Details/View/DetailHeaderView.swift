//
//  DetailHeaderView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
    
    let detailStatusView = DetailStatusView()
    var job = JobApp()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView = HorizontalStackView(arrangedSubviews: [
            detailStatusView
        ], spacing: 40, alignment: .center, distribution: .fillEqually)
        
        addSubview(hStackView)
        hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateUI(_ job : JobApp){
        self.job = job
        detailStatusView.updateUI(job)
        
    }
  
}
