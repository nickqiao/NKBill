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
    
}