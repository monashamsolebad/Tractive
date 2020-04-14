//
//  DetailFooter.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-21.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class DetailFooterView: UIStackView {
    
    let companyNameLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    let companyTitleLabel = UILabel(text: "Bank of America", font: .boldSystemFont(ofSize: 16),  textColor: .black )
    
    let emailLabel = UILabel(text: "Email", font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    let emailAddressLabel = UILabel(text: "robert.castro@gmail.com", font: .systemFont(ofSize: 16), textColor: .black)
    
    let phoneLabel = UILabel(text: "Phone", font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    let phoneNumberLabel = UILabel(text: "(604)358-1234", font: .systemFont(ofSize: 16), textColor: .black)
    
    let platformLabel = UILabel(text: "Platform", font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    let platformURLLabel = UILabel(text: "www.indeed.com", font: .systemFont(ofSize: 16), textColor: .black)
    
    let noteLabel = UILabel(text: "Note", font: .systemFont(ofSize: 12), textColor: .darkGray)
    
    let noteTextView: UILabel = {
        let nt = UILabel(frame: CGRect(x: 10, y: 100, width: 400, height:600))
        nt.translatesAutoresizingMaskIntoConstraints = false
        nt.textColor = .black
        nt.font = UIFont.systemFont(ofSize: 16)
        nt.numberOfLines = 10
        nt.lineBreakMode = .byClipping
        nt.text = ""
        return nt
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .leading
        self.distribution = .fill
        self.spacing = 20
        self.translatesAutoresizingMaskIntoConstraints = false
        setupCompanyStack()
        setupEmailStack()
        setupPhoneStack()
        setupPlatformStack()
        setupNoteStack()
        
    }
    
    func setupCompanyStack(){
        let companyStack = UIStackView()
        companyStack.axis = .vertical
        companyStack.distribution = .fill
        companyStack.addArrangedSubview(companyNameLabel)
        companyStack.addArrangedSubview(companyTitleLabel)
        self.addArrangedSubview(companyStack)
    }
    
    func setupEmailStack(){
        let emailStack = UIStackView()
        emailStack.axis = .vertical
        emailStack.distribution = .fill
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailAddressLabel)
        self.addArrangedSubview(emailStack)
    }
    
    func setupPhoneStack(){
        let phoneStack = UIStackView()
        phoneStack.axis = .vertical
        phoneStack.distribution = .fill
        phoneStack.addArrangedSubview(phoneLabel)
        phoneStack.addArrangedSubview(phoneNumberLabel)
        self.addArrangedSubview(phoneStack)
        
    }
    
    func setupPlatformStack(){
        let platformStack = UIStackView()
        platformStack.axis = .vertical
        platformStack.distribution = .fill
        platformStack.addArrangedSubview(platformLabel)
        platformStack.addArrangedSubview(platformURLLabel)
        self.addArrangedSubview(platformStack)
    }
    
    func setupNoteStack(){
        let noteStack = UIStackView()
        noteStack.axis = .vertical
        noteStack.distribution = .fill
        noteStack.addArrangedSubview(noteLabel)
        noteStack.addArrangedSubview(noteTextView)
        self.addArrangedSubview(noteStack)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(_ job : JobApp){
        companyTitleLabel.text = job.name
        emailAddressLabel.text = job.email
        if job.phone != "" { phoneNumberLabel.text = job.phone}
        platformURLLabel.text = job.link?.absoluteString
        if job.note != "" {
            noteTextView.text = job.note}
        platformURLLabel.text = job.platform
    }
}
