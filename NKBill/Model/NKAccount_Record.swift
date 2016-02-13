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
        
        if repayType == RepayType.RepayAllAtLast.rawValue {
            return  Float(passed) / 1.0
        }
        return  Float(passed) / Float(timeSpan)
    }
    
    func record_progressString() -> String {
        return "\(progress() * 100)%"
    }
    
    func record_name() -> String {
        return platform.name
    }
    
    func record_invest() -> String {
        return "\(invest)元"
    }
    
    func record_rate() -> String {
        return "\(rate * 100)%"
    }
    
    func record_date() -> String {
        return "\(created.NK_formatDate2())"
    }
     
}

