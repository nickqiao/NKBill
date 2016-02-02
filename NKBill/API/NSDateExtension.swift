//
//  NKConfigure.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NSDate {
    
    func NK_formatDate() -> String {
        let fmt = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "zh_CN")
        fmt.dateFormat = "yyyy年MM月dd日"
        return fmt.stringFromDate(self)
    }
    
    func NK_dateByAddingMonths(months: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = months
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateByAddingDays(days: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = days
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateBySubtractingDays(days: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.day = -1 * days
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }
    
    func NK_dateBySubtractingMonths(months: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.month = -1 * months
        return calendar.dateByAddingComponents(components, toDate: self, options: .MatchFirst)!
    }

    
    func isToday() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era,.Day,.Month,.Year], fromDate: NSDate())
        let today = calendar.dateFromComponents(components)
        
        let componets2 = calendar.components([.Era,.Day,.Month,.Year], fromDate: self)
        let other = calendar.dateFromComponents(componets2)
        return (today?.isEqualToDate(other!))!
    }
    /// only contains year month day
    func NK_date() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era,.Day,.Month,.Year], fromDate: self)
        return calendar.dateFromComponents(components)!
    }
    
}