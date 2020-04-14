//
//  Date+Utils.swift
//  Tractive
//
//  Created by Derrick Park on 11/18/19.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import Foundation

extension Date {
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
        
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
        return end - start
    }
    
    func getNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    func getPrevMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getLast6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -6, to: self)
    }
    
    func getNext6Month() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 6, to: self)
    }
}

