//
//  NKAccount_Record.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NKAccount {
    
    func progress() -> Float {
        
        let passed = items.filter(NSPredicate(format: "state == %@", State.Passed.rawValue)).count
        return  Float(passed) / Float(timeSpan)
    }
    
    func record_progressString() -> String {
        return "投资进度:\(progress() * 100)%"
    }
    
    func record_name() -> String {
        return platform.name
    }
    
    func record_invest() -> String {
        return "投资金额:\(invest)元"
    }
    
    func record_rate() -> String {
        
        switch timeTypeEnum {
        case .DAY:
            return "利率:\(rate * 100)%  期限:\(timeSpan)天"
        case .MONTH:
            return "利率:\(rate * 100)%  期限:\(timeSpan)个月"
        }
        
    }
    
    func record_date() -> String {
        return "投资日期:\(created.NK_formatDate())"
    }
     
}

