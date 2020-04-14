//
//  CompanyDetailView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class CompanyDetailView: UIStackView {
    
    let statusLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 18), textColor: .green)
    
    let statusImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "recieved")!)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
        return imageView
    }()
    
    let companyNameLabel = UILabel(text: "", font: .systemFont(ofSize: 12), textColor: .lightGray)
    
    let companyTitleLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), textColor: .white)
    
    let emailLabel = UILabel(text: "", font: .systemFont(ofSize: 12), textColor: .lightGray)
    
    let emailAddressLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .bold), textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBackground(color: .darkGray)
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isLayoutMarginsRelativeArrangement = true
        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        setupStatusStack()
        setupCompanyStack()
        setupEmailStack()
        
    }
    
    func setupStatusStack(){
        let statusHStackView = UIStackView()
        statusHStackView.translatesAutoresizingMaskIntoConstraints = false
        statusHStackView.axis = .horizontal
        statusHStackView.alignment = .center
        statusHStackView.distribution = .fillProportionally
        statusHStackView.addArrangedSubview(statusImage)
        statusHStackView.addArrangedSubview(statusLabel)
        self.addArrangedSubview(statusHStackView)
        statusImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1).isActive = true
    }
    
    
    func setupCompanyStack(){
        let companyStack = UIStackView()
        companyStack.translatesAutoresizingMaskIntoConstraints = false
        companyStack.axis = .vertical
        companyStack.distribution = .fill
        companyStack.addArrangedSubview(companyNameLabel)
        companyStack.addArrangedSubview(companyTitleLabel)
        self.addArrangedSubview(companyStack)
    }
    
    func setupEmailStack(){
        let emailStack = UIStackView()
        emailStack.translatesAutoresizingMaskIntoConstraints = false
        emailStack.axis = .vertical
        emailStack.distribution = .fill
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailAddressLabel)
        self.addArrangedSubview(emailStack)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
