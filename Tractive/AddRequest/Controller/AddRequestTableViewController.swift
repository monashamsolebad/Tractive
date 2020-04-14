//
//  AddRequestTableViewController.swift
//  Tractive
//
//  Created by Derrick Park on 10/9/19.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import DropDown
import CoreData

class AddRequestTableViewController: UITableViewController, CalandarDateSelectionDelegate {
    
    var job: JobApp?
    var editMode: String = "New"
    
    var presentCalendarView: (() -> ())?
    var platform : String = "Indeed"
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df
    }()
    
    @IBOutlet var statusButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var CompanyNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var linkTextField: UITextField!
    @IBOutlet var positionTitleTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var responsibleTextField: UITextField!
    @IBOutlet var noteTwxtView: UITextView!
    @IBOutlet var glassdoorPlatformButton: UIButton!
    @IBOutlet var facebookPlatformButton: UIButton!
    @IBOutlet var indeedPlatformButton: UIButton!
    
    private let dropDown = DropDown()
    private var selectedDate: Date?
    private var selectedDropDownItem = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateButton.setTitle(dateFormatter.string(from: Date()), for: .normal)
        self.presentCalendarView = {
            let calendar = CalendarViewController()
            calendar.calendarDateSelectionDelegate = self
            self.present(calendar, animated: true, completion: nil)
        }
        let image = UIImage(named: "sent-white")
        self.setButton(title: " SENT", image: image, backgroundColor: .filterStatusButtonBackgroundColor)
        noteTwxtView.layer.cornerRadius = 5
        registerKeyboardNotification()
        setupKeyboardDismissRecognizer()
        
    }
    
    func registerKeyboardNotification () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func  keyboardWasShown(_ notification: NSNotification) {
        guard let info =   notification.userInfo , let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
            else {return}
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInset = UIEdgeInsets (top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
        
    }
    func setupKeyboardDismissRecognizer(){
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    
    @objc func  keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInset = UIEdgeInsets.zero
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
    
    func didSelectDates(from date1: Date, to date2: Date) {
        didSelectDate(date1)
    }
    
    func didSelectDate(_ date: Date) {
        selectedDate = date
        dateButton.setTitle(dateFormatter.string(from: selectedDate!), for: .normal)
    }
    
    @IBAction func platformButtonTapped(_ sender: UIButton) {
        unSelectPlatformButton()
        sender.backgroundColor = .filterStatusButtonBackgroundColor
        platform = sender.titleLabel!.text!
    }
    
    func unSelectPlatformButton(){
        glassdoorPlatformButton.backgroundColor = UIColor.darkGray
        facebookPlatformButton.backgroundColor = UIColor.darkGray
        indeedPlatformButton.backgroundColor = UIColor.darkGray
    }
    
    
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        let date = selectedDate ?? Date()
        guard let email = emailTextField.text else { return }
        guard let urlStr = linkTextField.text else { return }
        guard let name = CompanyNameTextField.text else { return }
        guard let note = noteTwxtView.text else { return }
        guard let position = positionTitleTextField.text else { return }
        guard let phone = phoneNumberTextField.text else { return }
        
        if validateName(name: name) && validateEmail(email: email) && validatePhone(phoneNumber: phone)  {
            if editMode == "New" {
                JobApp.addApplication(id: UUID(), date: date, email: email, link: URL(string: urlStr), name: name, note: note, phone: phoneNumberTextField.text, position: position, responsiblePerson: responsibleTextField.text , status: Int16(selectedDropDownItem),platform :platform)
            } else {
                JobApp.editApplication(id: job!.id!, date: date, email: email, link: URL(string: urlStr), name: name, note: note, phone: phoneNumberTextField.text, position: position, responsiblePerson: responsibleTextField.text , status: Int16(selectedDropDownItem),platform :platform)
                editMode = "New"
            }
            normalTextField(CompanyNameTextField)
            normalTextField(emailTextField)
            normalTextField(phoneNumberTextField)
            tabBarController?.selectedIndex = 0
        }
        if validateName(name: name) == false {
            changeBorderColor(CompanyNameTextField)
        }
        if validateEmail(email: email) == false {
            changeBorderColor(emailTextField)
        }
        if validatePhone(phoneNumber: phone) == false {
            changeBorderColor(phoneNumberTextField)
        }
        if validateName(name: name) {
            normalTextField(CompanyNameTextField)
        }
        if validateEmail(email: email) {
            normalTextField(emailTextField)
        }
        if validatePhone(phoneNumber: phone) {
            normalTextField(phoneNumberTextField)
        }
    }
    
    @IBAction private func statusButtonTapped(_ sender: UIButton) {
        DropDown.appearance().backgroundColor = .clear
        dropDown.anchorView = sender
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.cellNib = UINib(nibName: "StatusCell", bundle: nil)
        dropDown.dataSource = ["SENT", "RECEIVED", "CANCELED"]
        dropDown.width = self.view.bounds.width / 2.5
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? StatusCell else { return }
            cell.contentView.layer.cornerRadius = 16
            cell.contentView.clipsToBounds = true
            if index == 0 {
                cell.contentView.backgroundColor = .filterStatusButtonBackgroundColor
                cell.iconImageView.image =  UIImage(named: "sent-white")
            } else if index == 1 {
                cell.contentView.backgroundColor = .recievedStatusButtonColor
                cell.iconImageView.image =  UIImage(named: "recieved-white")
            } else if index == 2 {
                cell.contentView.backgroundColor = .cancelColor
                cell.iconImageView.image =  UIImage(named: "canceled-white")
            }
        }
        dropdownSelection()
        
    }
    
    @IBAction private func dateButtonTapped(_ sender: UIButton) {
        presentCalendarView?()
    }
    
    private func setButton(title: String, image: UIImage?, backgroundColor: UIColor?) {
        statusButton.setTitle(title, for: .normal)
        if let backgroundColor = backgroundColor {
            statusButton.backgroundColor = backgroundColor
        }
        if let image = image {
            statusButton.setImage(image, for: .normal)
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        clearForm()
    }
    
    private func validateName(name : String) ->Bool {
        if name == "" {
            return false
        }
        return true
    }
    
    private func validateEmail(email: String) -> Bool {
        if email == "" {
            return false
        }
        else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let trimmedString = email.trimmingCharacters(in: .whitespaces)
            let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValidateEmail = validateEmail.evaluate(with: trimmedString)
            return isValidateEmail
        }
    }
    private func validatePhone(phoneNumber: String) -> Bool {
          if phoneNumber == "" {
              return true
          }
          else {
              let phoneNumberRegex = "^[6-9]\\d{9}$"
              let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
              let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
              let isValidPhone = validatePhone.evaluate(with: trimmedString)
              return isValidPhone
          }
      }
    
    private func changeBorderColor(_ textField : UITextField){
        textField.layer.borderWidth = 3.5
        textField.layer.cornerRadius = 10
        textField.layer.borderColor =  UIColor.red.cgColor
    }
    private func normalTextField(_ textField : UITextField) {
        textField.layer.borderWidth = 0
        textField.layer.cornerRadius = 0
        textField.layer.borderColor =  UIColor.gray.cgColor
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.text = headerView.textLabel?.text?.capitalized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if editMode == "New" {
            clearForm()
        }
        if editMode == "Edit" {
            fillForm()
        }
    }
    
    private func clearForm(){
        CompanyNameTextField.text = ""
        emailTextField.text = ""
        linkTextField.text = ""
        positionTitleTextField.text = ""
        phoneNumberTextField.text = ""
        responsibleTextField.text = ""
        noteTwxtView.text = ""
        CompanyNameTextField.resignFirstResponder()
    }
    
    private func fillForm(){
        unSelectPlatformButton()
        CompanyNameTextField.text = job?.name
        emailTextField.text = job?.email
        linkTextField.text = job?.link?.absoluteString
        positionTitleTextField.text = job?.position
        phoneNumberTextField.text = job?.phone
        responsibleTextField.text = job?.responsiblePerson
        noteTwxtView.text = job?.note
        if glassdoorPlatformButton.titleLabel?.text == job?.platform {
            glassdoorPlatformButton.backgroundColor =  .filterStatusButtonBackgroundColor
        }
        else if facebookPlatformButton.titleLabel?.text == job?.platform {
            facebookPlatformButton.backgroundColor =  .filterStatusButtonBackgroundColor
        }
        else if indeedPlatformButton.titleLabel?.text == job?.platform {
            indeedPlatformButton.backgroundColor =  .filterStatusButtonBackgroundColor
        }
        switch job?.status {
        case 1:
            selectedDropDownItem = 1
        case 2:
            selectedDropDownItem = 2
        default:
            selectedDropDownItem = 0
        }
        
        CompanyNameTextField.becomeFirstResponder()
        selectedDate = job!.date!
        dateButton.setTitle(dateFormatter.string(from: selectedDate!), for: .normal)
        
        var image = UIImage(named: "")
        var title = ""
        var color : UIColor
        switch job?.status {
        case 1 :
            image = UIImage(named: "recieved-white")
            title = " Recieved"
            color = .recievedStatusButtonColor
            self.selectedDropDownItem = 1
        case 2 :
            image = UIImage(named: "canceled-white")
            self.selectedDropDownItem = 2
            title = " Canceled"
            color = .cancelColor
        default:
            image = UIImage(named: "sent-white")
            self.selectedDropDownItem = 0
            title = " Sent"
            color = .filterStatusButtonBackgroundColor
        }
        self.setButton(title: title, image: image, backgroundColor: color)
    }
    
    private func dropdownSelection(){
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            var bgColor : UIColor
            var image = UIImage(named: "")
            switch item {
            case "SENT":
                image = UIImage(named: "sent-white")
                self.selectedDropDownItem = 0
                bgColor = .filterStatusButtonBackgroundColor
            case "RECEIVED" :
                image = UIImage(named: "recieved-white")
                self.selectedDropDownItem = 1
                bgColor = .recievedStatusButtonColor
            case "CANCELED" :
                image = UIImage(named: "canceled-white")
                self.selectedDropDownItem = 2
                bgColor = .cancelColor
            default:
                image = UIImage(named: "AllIcon")
                bgColor = .darkGray
            }
            self.setButton(title: item, image: image, backgroundColor: bgColor)
        }
        
        dropDown.show()
    }
    
}


