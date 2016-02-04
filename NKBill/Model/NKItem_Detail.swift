//
//  NKItem_detail.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NKItem {
    
    func Detail_platName() -> String {
        return account.platform.name
    }
    
    func Detail_repayDate() -> String {
        return repayDate.NK_formatDate()
    }
    
    func Detail_interest() -> String {
        return String(format: "%.2f", interest)
    }
    
    func Detail_principal() -> String {
        return String(format: "%.2f", principal)
    }
    
    func Detail_sum() -> String {
        return String(format: "%.2f", principal + interest)
    }
    
    func Detail_state() -> String {
        switch state {
        case State.Overdue.rawValue:
            return "逾期"
        case State.Passed.rawValue:
            return "已还"
        case State.Waiting.rawValue:
            return "待还"
        default:
            return "待还"
        }
    }
    
}
