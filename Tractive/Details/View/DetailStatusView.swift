//
//  DetailStatusView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-24.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DetailStatusView: UIView {
    
    let statusLabel: UILabel = {
        let lb = UILabel(text: "Sent", font: .systemFont(ofSize: 12), textColor: .white)
        lb.textAlignment = .center
        return lb
    }()
    
    let calandarLabel: UILabel = {
        let lb = UILabel(text: "July 4, 2019", font: .systemFont(ofSize: 16), textColor: .white)
        lb.textAlignment = .center
        return lb
    }()
    
    let numberLabel = UILabel(text: "5", font: .boldSystemFont(ofSize: 50), textColor: .white)
    
    let daysLabel = UILabel(text: "days ago", font: .systemFont(ofSize: 12), textColor: .white)
   
    let dateFormatter: DateFormatter = {
          let fmt = DateFormatter()
          fmt.dateFormat = "yyyy-MM-dd"
          return fmt
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStackView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        borderWidth = 1
    }
    
    private func setupStackView() {
        let vsv = VerticalStackView(arrangedSubviews: [
            statusLabel, calandarLabel, numberLabel, daysLabel
        ], alignment: .center, distribution: .fill)
        addSubview(vsv)
        vsv.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateUI(_ job : JobApp){
        var color : UIColor
        switch job.status {
        case 1 :
            statusLabel.text = "Recieved"
            color = .recievedStatusButtonColor
        case 2 :
            statusLabel.text = "Canceled"
            color = .cancelColor
        default :
              statusLabel.text = "Sent"
              color = .filterStatusButtonBackgroundColor
        }
        let dateString = dateFormatter.string(from: job.date!)
        let days = Date().interval(ofComponent: .day, fromDate: job.date!)
        numberLabel.text = String(days)
        calandarLabel.text = dateString
        backgroundColor = color
        borderColor = color
        
        
    }
}
