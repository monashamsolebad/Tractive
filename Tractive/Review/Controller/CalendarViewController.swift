//
//  CalendarViewController.swift
//  Tractive
//
//  Created by Mona Shamsolebad on 2019-10-17.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol CalandarDateSelectionDelegate: class {
    func didSelectDates(from date1: Date, to date2: Date)
    func didSelectDate(_ date: Date)
}

class CalendarViewController: UIViewController {
    
    weak var calendarDateSelectionDelegate: CalandarDateSelectionDelegate?
    var firstDate: Date?
    var twoDatesAlreadySelected: Bool {
        return firstDate != nil && calendarView.selectedDates.count > 1
    }
    
    private let calendarView: JTACMonthView = {
        let jt = JTACMonthView()
        jt.translatesAutoresizingMaskIntoConstraints = false
        jt.scrollingMode = .stopAtEachCalendarFrame
        jt.allowsMultipleSelection = true
        jt.allowsRangedSelection = true
        jt.scrollDirection = .horizontal
        jt.backgroundColor = .white
        
        return jt
    }()
    
    let cancelBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("CANCEL", for: .normal)
        btn.setTitleColor(.cancelColor, for: .normal)
        return btn
    }()
    
    let okBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("OK", for: .normal)
        btn.setTitleColor(.filterStatusButtonBackgroundColor, for: .normal)
        return btn
    }()
    
    private let formatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM yyyy"
        return df
    }()
    
    private let monthFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM"
        return df
    }()
    
    private let now = Date()
    
    private func setupUI() {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        
        let hs = HorizontalStackView(arrangedSubviews: [cancelBtn, okBtn], alignment: .center, distribution: .equalCentering)
        container.addSubview(hs)
        view.addSubview(calendarView)
        view.addSubview(container)
        
        calendarView.layer.cornerRadius = 8
        calendarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        calendarView.centerXYin(view)
        calendarView.constraintWidth(equalToConstant: 350, heightEqualToConstant: 350)
        container.anchors(topAnchor: calendarView.bottomAnchor, leadingAnchor: calendarView.leadingAnchor, trailingAnchor: calendarView.trailingAnchor, bottomAnchor: nil, size: .init(width: 350, height: 60))
        hs.matchParent(padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        container.layer.cornerRadius = 8
        container.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        cancelBtn.addTarget(self, action: #selector(cancelBtnTapped), for: .touchUpInside)
        okBtn.addTarget(self, action: #selector(okBtnTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        calendarView.scrollToDate(now, animateScroll: false)
        calendarView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(DateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "dateHeader")
        
        calendarView.ibCalendarDataSource = self
        calendarView.ibCalendarDelegate = self
    }
    
    @objc func cancelBtnTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func okBtnTapped(_ sender: UIButton) {
        if calendarView.selectedDates.count == 1 {
            self.dismiss(animated: true) {
                self.calendarDateSelectionDelegate?.didSelectDate(self.firstDate!)
            }
        }
        
        if calendarView.selectedDates.count > 1 {
            self.dismiss(animated: true) {
                self.calendarDateSelectionDelegate?.didSelectDates(from: self.calendarView.selectedDates.first!, to: self.calendarView.selectedDates.last!)
            }
        }
    }
    
    private func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell else { return }
        
        if Calendar.current.isDateInToday(cellState.date) {
            cell.setTodayStatus(color: .filterStatusButtonBackgroundColor)
        } else {
            cell.setTodayStatus(color: .white)
        }

        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    private func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = UIColor.black
        } else {
            cell.dateLabel.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        cell.selectedStatus.isHidden = !cellState.isSelected
        switch cellState.selectedPosition() {
        case .left:
            cell.setSelectedStatus(color: .cancelColor)
        case .middle:
            cell.setSelectedStatus(color: .cancelColor)
        case .right:
            cell.setSelectedStatus(color: .cancelColor)
        case .full:
            cell.setSelectedStatus(color: .cancelColor)
        default: break
        }
    }
}

extension CalendarViewController: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: now.getLast6Month()!, endDate: now.getNext6Month()!, generateInDates: .forAllMonths, generateOutDates: .tillEndOfGrid)
    }
}

extension CalendarViewController: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        if let firstDate = firstDate {
            calendar.selectDates(from: firstDate, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
        } else {
            firstDate = date
        }
        configureCell(view: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        if twoDatesAlreadySelected && cellState.selectionType != .programatic || firstDate != nil && calendarView.selectedDates.count > 0 && date < calendarView.selectedDates[0] {
            firstDate = nil
            let retval = !calendarView.selectedDates.contains(date)
            calendarView.deselectAllDates()
            return retval
        }
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, shouldDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) -> Bool {
        if twoDatesAlreadySelected && cellState.selectionType != .programatic {
            firstDate = nil
            calendarView.deselectAllDates()
            return false
        }
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "dateHeader", for: indexPath) as! DateHeader
        
        header.prevMonthTitle.text = monthFormatter.string(from: range.start.getPrevMonth()!)
        header.monthTitle.text = formatter.string(from: range.start)
        header.nextMonthTitle.text = monthFormatter.string(from: range.start.getNextMonth()!)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 64)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let visibleDates = calendarView.visibleDates()
        calendarView.viewWillTransition(to: .zero, with: coordinator, anchorDate: visibleDates.monthDates.first?.date)
    }
}

