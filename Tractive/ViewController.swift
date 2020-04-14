//
//  ViewController.swift
//  Tractive
//
//  Created by Derrick Park on 9/27/19.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        let spacing: CGFloat = 12
        let column: CGFloat = 2
        let width: CGFloat = (view.frame.size.width / column) - (spacing * (column + 1))

        let one = StatsCategoryView()
        one.widthAnchor.constraint(equalToConstant: width).isActive = true
        one.heightAnchor.constraint(equalToConstant: width).isActive = true
        one.statsCategory = StatsCategory(imageIconName: "IconPlane", categoryName: "Total Send", stats: 573)
        
        
        let two = StatsCategoryView()
        two.widthAnchor.constraint(equalToConstant: width).isActive = true
        two.heightAnchor.constraint(equalToConstant: width).isActive = true
        two.statsCategory = StatsCategory(imageIconName: "Vector", categoryName: "Total Received", stats: 194)
        
        
        let three = StatsCategoryView()
        three.widthAnchor.constraint(equalToConstant: width).isActive = true
        three.heightAnchor.constraint(equalToConstant: width).isActive = true
        three.statsCategory = StatsCategory(imageIconName: "Cancel", categoryName: "Total Canceled", stats: 17)
        

        let four = StatsCategoryView()
        four.widthAnchor.constraint(equalToConstant: width).isActive = true
        four.heightAnchor.constraint(equalToConstant: width).isActive = true
        four.statsCategory = StatsCategory(imageIconName: "AllIcon", categoryName: "Total Companies", stats: 569)
        

        let five = StatsCategoryView()
        five.widthAnchor.constraint(equalToConstant: width).isActive = true
        five.heightAnchor.constraint(equalToConstant: width).isActive = true
        five.statsCategory = StatsCategory(imageIconName: "Group 4", categoryName: "Send this Month", stats: 51)
        

        let six = StatsCategoryView()
        six.widthAnchor.constraint(equalToConstant: width).isActive = true
        six.heightAnchor.constraint(equalToConstant: 162).isActive = true
        six.statsCategory = StatsCategory(imageIconName: "Group 4.1", categoryName: "Send this Year", stats: 529)
        

        
        let row1 = UIStackView(arrangedSubviews: [one, two])
        row1.translatesAutoresizingMaskIntoConstraints = false
        row1.axis = .horizontal
        row1.alignment = .center
        row1.distribution = .fillEqually
        row1.spacing = 15
        
        
        let row2 = UIStackView(arrangedSubviews: [three, four])
        row2.translatesAutoresizingMaskIntoConstraints = false
        row2.axis = .horizontal
        row2.alignment = .center
        row2.distribution = .fillEqually
        row2.spacing = 15
        
        let row3 = UIStackView(arrangedSubviews: [five, six])
        row3.translatesAutoresizingMaskIntoConstraints = false
        row3.axis = .horizontal
        row3.alignment = .center
        row3.distribution = .fillEqually
        row3.spacing = 15
        
        let verticalSV = UIStackView(arrangedSubviews: [row1, row2, row3])
        verticalSV.translatesAutoresizingMaskIntoConstraints = false
        verticalSV.axis = .vertical
        verticalSV.distribution = .fillEqually
        verticalSV.alignment = .center
        verticalSV.spacing = 20
        
        view.addSubview(verticalSV)
        verticalSV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verticalSV.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

