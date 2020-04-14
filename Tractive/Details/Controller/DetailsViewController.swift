//
//  DetailsViewController.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-20.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import DropDown
import SafariServices
import MessageUI

class DetailsViewController: UIViewController , MFMailComposeViewControllerDelegate {
    var job: JobApp!
    
    var mainTabBarController: MainTabBarController?
    
    let detailHeaderView: DetailHeaderView = {
        let dh = DetailHeaderView()
        return dh
    }()
    
    let detailFooterView: DetailFooterView = {
        let df = DetailFooterView()
        return df
    }()
    
    let editButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .filterStatusButtonBackgroundColor
        sb.setTitle("Edit", for: .normal)
        sb.setTitleColor(UIColor.white, for: .normal)
        sb.setTitleColor(UIColor.gray, for: .highlighted)
        sb.layer.cornerRadius = 10
        sb.clipsToBounds = true
        
        return sb
    }()
    
    let emailButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .white
        sb.setTitle(" Email", for: .normal)
        sb.setImage(UIImage(named: "email"), for: .normal)
        sb.setTitleColor(.filterStatusButtonBackgroundColor, for: .normal)
        sb.setTitleColor(.filterStatusButtonBackgroundColor, for: .highlighted)
        sb.layer.cornerRadius = 10
        sb.clipsToBounds = true
        sb.borderColor = .filterStatusButtonBackgroundColor
        sb.borderWidth = 1
        
        return sb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = true
        scrollView.matchParent()
        
        detailHeaderView.updateUI(job)
        scrollView.addSubview(detailHeaderView)
        detailHeaderView.anchors(topAnchor: scrollView.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        detailFooterView.updateUI(job)
        scrollView.addSubview(detailFooterView)
        detailFooterView.anchors(topAnchor: detailHeaderView.bottomAnchor, leadingAnchor: detailHeaderView.leadingAnchor, trailingAnchor: detailHeaderView.trailingAnchor, bottomAnchor: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0))
        
        let buttonsHStackView = HorizontalStackView(arrangedSubviews: [editButton, emailButton], spacing: 25, alignment: .fill, distribution: .fillEqually)
        scrollView.addSubview(buttonsHStackView)
        editButton.constraintHeight(equalToConstant: 50)
        emailButton.constraintHeight(equalToConstant: 50)
        buttonsHStackView.anchors(topAnchor: detailFooterView.bottomAnchor, leadingAnchor: detailFooterView.leadingAnchor, trailingAnchor: detailFooterView.trailingAnchor, bottomAnchor: scrollView.bottomAnchor, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped(_:)), for: .touchUpInside)
        self.mainTabBarController = self.presentingViewController as? MainTabBarController
        
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            let addRequestController = (self.mainTabBarController?.viewControllers?[2] as! UINavigationController).topViewController as! AddRequestTableViewController
            addRequestController.job = self.job
            addRequestController.editMode = "Edit"
            self.mainTabBarController?.selectedIndex = 2
            
        }
        
    }
    @objc func emailButtonTapped (_ sender : UIButton) {
        
            if !MFMailComposeViewController.canSendMail() {
                return
            }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([job.email!])
        mailComposer.setSubject("")
        mailComposer.setMessageBody("", isHTML: false)
        present(mailComposer,animated: true,completion: nil)
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}

