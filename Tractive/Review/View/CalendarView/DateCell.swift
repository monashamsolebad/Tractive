//
//  DateCell.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DateCell: JTACDayCell {
    
    let dateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let todayStatus: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let selectedStatus: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let sv = VerticalStackView(arrangedSubviews: [dateLabel, todayStatus, selectedStatus], alignment: .center)
        todayStatus.constraintHeight(equalToConstant: 5)
        todayStatus.widthAnchor.constraint(equalTo: sv.widthAnchor).isActive = true
        selectedStatus.constraintHeight(equalToConstant: 5)
        selectedStatus.widthAnchor.constraint(equalTo: sv.widthAnchor).isActive = true
        contentView.addSubview(sv)
        sv.matchParent()
    }
    
    func setTodayStatus(color: UIColor) {
        todayStatus.backgroundColor = color
    }
    
    func setSelectedStatus(color: UIColor) {
        selectedStatus.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
