//
//  HeaderView.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-09.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import DropDown

class HeaderView: UIView {
    
    var statusSelectDelegate : StatusSelectionDelegate?
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "search company name"
        sb.sizeToFit()
        sb.searchBarStyle = .minimal
        sb.image(for: .search, state: .focused)
        sb.searchTextField.textColor = .white
        sb.searchTextField.font = UIFont.systemFont(ofSize: 15)
        sb.translatesAutoresizingMaskIntoConstraints = false
        return sb
    }()
    
    let searchButton: UIButton = {
        let sb = UIButton()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = .filterStatusButtonBackgroundColor
        sb.setTitle("Search", for: .normal)
        sb.setTitleColor(UIColor.white, for: .normal)
        sb.setTitleColor(UIColor.gray, for: .highlighted)
        sb.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        sb.layer.cornerRadius = 10
        sb.clipsToBounds = true
        
        return sb
    }()
    
    let statusFilterView: FilterView = {
        let fv = FilterView()
        fv.setLabel(text: "Filter Status", backgroundColor: .tractiveBackgroudColor, textColor: .gray)
        fv.setButton(title: "ALL", image: UIImage(named: "AllIcon"), backgroundColor: .darkGray)
        return fv
    }()
    
    let dateFilterView: FilterView = {
        let dv = FilterView()
        dv.setLabel(text: "Select Date", backgroundColor: .tractiveBackgroudColor, textColor: .gray)
        dv.setButton(title: "Select Date", image: nil, backgroundColor: .darkGray)
        return dv
    }()
    
    var presentCalendarView: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.tractiveBackgroudColor
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        let searchStackView = HorizontalStackView(arrangedSubviews: [searchBar, searchButton], alignment: .center, distribution: .fill)
        searchButton.widthAnchor.constraint(equalTo: searchStackView.widthAnchor, multiplier: 0.2).isActive = true
        
        let filtersHStackView = HorizontalStackView(arrangedSubviews: [statusFilterView, dateFilterView], alignment: .fill, distribution: .fillEqually)
        
        let headerVStackView = VerticalStackView(arrangedSubviews: [
            searchStackView,
            filtersHStackView
        ], alignment: .fill, distribution: .fillProportionally)
        self.addSubview(headerVStackView)
        
        headerVStackView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, bottomAnchor: bottomAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        statusFilterView.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        dateFilterView.addTarget(self, action: #selector(dateButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func dateButtonTapped(_ sender: UIButton) {
        presentCalendarView?()
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        
        
        let dropDown = DropDown()
        
        DropDown.appearance().backgroundColor = .clear
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cellNib = UINib(nibName: "StatusCell", bundle: nil)
        dropDown.dataSource = ["ALL", "SENT", "RECEIVED", "CANCELED"]
        dropDown.width = self.bounds.width / 2.5
    
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? StatusCell else { return }
            
            cell.contentView.layer.cornerRadius = 16
            cell.contentView.clipsToBounds = true
            if index == 0 {
                cell.contentView.backgroundColor = .darkGray
                cell.iconImageView.image =  UIImage(named: "AllIcon")
            } else if index == 1 {
                cell.contentView.backgroundColor = .filterStatusButtonBackgroundColor
                
                cell.iconImageView.image =  UIImage(named: "sent-white")
            } else if index == 2 {
                cell.contentView.backgroundColor = .recievedStatusButtonColor
               
                cell.iconImageView.image =  UIImage(named: "recieved-white")
            }else if index == 3 {
                cell.contentView.backgroundColor = .cancelColor
                
                cell.iconImageView.image =  UIImage(named: "canceled-white")
            }
        }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            var bgColor : UIColor
            var image = UIImage(named: "")
            switch item {
            case "SENT":
                image = UIImage(named: "sent-white")
                self.statusSelectDelegate?.didSelectStatus(0)
                bgColor = .filterStatusButtonBackgroundColor
            case "RECEIVED" :
                image = UIImage(named: "recieved-white")
                self.statusSelectDelegate?.didSelectStatus(1)
                bgColor = .recievedStatusButtonColor
            case "CANCELED" :
                image = UIImage(named: "canceled-white")
                self.statusSelectDelegate?.didSelectStatus(2)
                bgColor = .cancelColor
            default:
                image = UIImage(named: "AllIcon")
                self.statusSelectDelegate?.didSelectStatus(3)
                bgColor = .darkGray
            }
            self.statusFilterView.setButton(title: item, image: image, backgroundColor: bgColor)
        }
        
        dropDown.show()
    }
    
}
