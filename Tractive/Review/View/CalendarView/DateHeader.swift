//
//  DateHeader.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-22.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateHeader: JTACMonthReusableView {
    
    let monthTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .filterStatusButtonBackgroundColor
        lb.font = UIFont.systemFont(ofSize: 20)
        return lb
    }()
    
    let prevMonthTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    let nextMonthTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 16)
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        let daysStr = ["S", "M", "T", "W", "R", "F", "S"]
        var days: [UILabel] = []
        for i in 0..<7 {
            let lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            lb.textColor = .lightGray
            lb.font = UIFont.systemFont(ofSize: 14)
            lb.text = daysStr[i]
            days.append(lb)
        }
        
        let hs = HorizontalStackView(arrangedSubviews: days, alignment: .center, distribution: .equalCentering)
        let hss = HorizontalStackView(arrangedSubviews: [prevMonthTitle, monthTitle, nextMonthTitle], alignment: .center, distribution: .equalCentering)
        addSubview(hs)
        addSubview(hss)
        hs.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 16))
        hss.anchors(topAnchor: hs.bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
