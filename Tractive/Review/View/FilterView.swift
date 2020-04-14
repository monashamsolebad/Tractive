//
//  FilterView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import DropDown

class FilterView: UIStackView {
    
    private let filterLabel = UILabel(text: "", font: .systemFont(ofSize: 15))
    
    private let filterButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.layer.cornerRadius = 16
        bt.clipsToBounds = true
        bt.titleLabel?.font = .boldSystemFont(ofSize: 15)
        bt.titleLabel?.adjustsFontSizeToFitWidth = true
        let spacing : CGFloat = 5
        bt.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing);
        bt.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: 0);
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .leading
        self.distribution = .fillProportionally
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(filterLabel)
        self.addArrangedSubview(filterButton)
        
        filterButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MMM"
        return df
    }()
    
    func setDate(from date1: Date, to date2: Date) {
        filterButton.setTitle("🗓 " + formatter.string(from: date1) + "-" + formatter.string(from: date2), for: .normal)
    }
    
    func setLabel(text: String, backgroundColor: UIColor?, textColor: UIColor?) {
        filterLabel.text = text
        if let backgroundColor = backgroundColor {
            filterLabel.backgroundColor = backgroundColor
        }
        if let textColor = textColor {
            filterLabel.textColor = textColor
        }
    }
    
    func setButton(title: String, image: UIImage?, backgroundColor: UIColor?) {
        filterButton.setTitle(title, for: .normal)
        if let backgroundColor = backgroundColor {
            filterButton.backgroundColor = backgroundColor
        }
        if let image = image {
            filterButton.setImage(image, for: .normal)
        }
    }
    
    func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        filterButton.addTarget(target, action: action, for: controlEvents)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
