//
//  StatsCategoryView.swift
//  Tractive
//
//  Created by Sean Chien on 2019-10-07.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class StatsCategoryView: UIView {

    var statsCategory: StatsCategory? {
        didSet {
            if let statsCategory = statsCategory {
                self.iconImage.image = UIImage(named: statsCategory.imageIconName)
                self.categoryLabel.text = statsCategory.categoryName
                self.statsLabel.text = "\(statsCategory.stats)"
            }
        }
    }
    
    var iconImage: UIImageView = {
        let ic = UIImageView()
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.contentMode = .scaleAspectFill
        return ic
    }()
    
    var categoryLabel: UILabel = {
        let lb = UILabel(text: "", font: .systemFont(ofSize: 18), textColor: .white)
        lb.textAlignment = .center
        return lb
    }()
    
    var statsLabel: UILabel = {
        let lb = UILabel(text: "", font: .boldSystemFont(ofSize: 50), textColor: .init(red: 76/255, green: 102/255, blue: 196/255, alpha: 1.0))
        lb.textAlignment = .center
        return lb
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.backgroundColor = .tractiveBackgroudColor
        let vStackView = VerticalStackView(arrangedSubviews: [iconImage, categoryLabel, statsLabel], alignment: .center, distribution: .equalSpacing)
        addSubview(vStackView)
        vStackView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 20, left: 0, bottom: 16, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
