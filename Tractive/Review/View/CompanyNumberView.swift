//
//  CompanyNumberView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class CompanyNumberView: UIStackView {
    
    lazy var daysLabel: UILabel = {
        let lb = UILabel(text: "", font: nil, textColor: .white)
        lb.backgroundColor = .filterStatusButtonBackgroundColor
        return lb
    }()
    
    let dateLabel: UILabel = {
        let lb = UILabel(text: "", font: .systemFont(ofSize: 15), textColor: .lightGray)
        lb.textAlignment = .center
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        distribution = .fill

        addArrangedSubview(daysLabel)
        addArrangedSubview(dateLabel)
        daysLabel.widthAnchor.constraint(equalTo: daysLabel.heightAnchor, multiplier: 1.0, constant: 0).isActive = true
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
