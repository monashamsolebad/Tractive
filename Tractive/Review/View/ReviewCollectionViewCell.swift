//
//  ReviewCollectionViewCell.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-03.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var uuid = UUID()
    
    let companyDetailView: CompanyDetailView = {
        let cv = CompanyDetailView()
        cv.companyNameLabel.text = "Company Name"
        cv.emailLabel.text = "Email"
        return cv
    }()
    
    lazy var companyNumberView: CompanyNumberView = {
        let cn = CompanyNumberView()
        cn.daysLabel.layer.cornerRadius = (self.bounds.size.width - 24) * (3 / 10) * (1 / 2) - 2
        cn.daysLabel.clipsToBounds = true
        return cn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.backgroundColor = .darkGray
        self.contentView.layer.cornerRadius = 8
        self.contentView.clipsToBounds = true
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    let dateFormatter: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt
    }()
    
    func updateUI(job: JobApp, index: Int) {
        uuid = job.id!
        companyDetailView.companyTitleLabel.text = job.name
        companyDetailView.emailAddressLabel.text = job.email
        //companyNumberView.idLabel.text = "ID #" + String(index + 1)
        
        let dateString = dateFormatter.string(from: job.date!)
        companyNumberView.dateLabel.text = dateString
        let days = Date().interval(ofComponent: .day, fromDate: job.date!)
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let daysString = NSMutableAttributedString(string: String(days), attributes: [.font : UIFont.boldSystemFont(ofSize: 30), .paragraphStyle: paragraph])
        let labelString = NSMutableAttributedString(string: "\ndays ago", attributes: [.font : UIFont.systemFont(ofSize: 11), .paragraphStyle: paragraph])
        daysString.append(labelString)
        companyNumberView.daysLabel.numberOfLines = 2
        companyNumberView.daysLabel.attributedText = daysString
        
        switch job.status {
        case 1:
            companyDetailView.statusLabel.text = " RECIEVED"
            companyDetailView.statusImage.image = UIImage(named: "recieved")
            companyDetailView.statusLabel.textColor = .recieveStatusButtonColor
        case 2:
            companyDetailView.statusLabel.text = " CANCELED"
            companyDetailView.statusLabel.textColor = .cancelColor
            companyDetailView.statusImage.image = UIImage(named: "canceled")
        default:
            companyDetailView.statusLabel.text = " SENT"
            companyDetailView.statusLabel.textColor = .filterStatusButtonBackgroundColor
            companyDetailView.statusImage.image = UIImage(named: "sent")
        }
    }
    
    private func initSubViews(){
        
        let detailsHStackView = HorizontalStackView(arrangedSubviews: [companyDetailView, companyNumberView], spacing: 0, alignment: .fill, distribution: .fillProportionally)
        self.addSubview(detailsHStackView)
        companyDetailView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7, constant: -12).isActive = true
        companyNumberView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3, constant: -12).isActive = true
        detailsHStackView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
}
