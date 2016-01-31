//
//  NKAccount.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

enum TimeType {
    case MONTH
    case DAY
}

enum RepaymentType {
    case AverageCapital
    case InterestByMonth
    case InterestByDay
    case RepayAllAtLast
}

class NKAccount: NSObject {
    
    var platform = NKPlatform()
    var invest = 0
    var rate: Float = 0.0
    var timeType: TimeType = .MONTH
    var timeSpan = 0
    var date: NSDate = NSDate(timeIntervalSinceNow: 0.0)
    var repaymentType: RepaymentType = .AverageCapital
    
}

extension NKAccount {
    
    func compose_name() -> (String,String) {
        return ("投资平台:",platform.name)
    }
    
    func compose_invest() -> (String,String) {
        return ("投资金额","¥\(invest)")
    }
    
    func compose_rate() -> (String,String) {
        if rate == 0.0 {
            return ("年利率","")
        }
        if rate > 0.5 {
            return ("年利率","60%")
        }
        
        return ("年利率","\(rate * 100)%")
        
    }
    
    func compose_timeSpan() -> (String,String) {
        switch timeType {
        case .DAY:
            return ("期限","\(timeSpan)天")
        case .MONTH:
            return ("期限","\(timeSpan)个月")
        }
    }
    
    func compose_date() -> (String,String) {
        let fmt = NSDateFormatter()
        fmt.locale = NSLocale(localeIdentifier: "zh_CN")
        fmt.dateFormat = "yyyy年MM月dd日"
        return ("起息日",fmt.stringFromDate(date))
    }
    
    func compose_repaymentType() -> (String,String) {
        switch repaymentType {
        case .AverageCapital:
            return ("还款方式","等额本息")
        case .InterestByMonth:
            return ("还款方式","按月计息,到期还本")
        case .InterestByDay:
            return ("还款方式","按日计息,到期还本")
        case .RepayAllAtLast:
            return ("还款方式","到期还本息")
        }
    }
    
}
