//
//  StatusCell.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-15.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import DropDown

class StatusCell: DropDownCell {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        statusLabel.textColor = .white
    }
}
