//
//  NKItem_Schedule.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NKItem {
    
    func schedule_platName() -> String {
        return account.platform.name
    }
    
    func schedule_repayDate() -> String {
        return String(format: "还款日期:%@", repayDate.NK_formatDate())
    }
    
    func schedule_interest() -> String {
        return String(format: "应收利息:%.2f", interest)
    }
    
    func schedule_principal() -> String {
        return String(format: "应收本金:%.2f", principal)
    }
    
    func schedule_sum() -> String {
        return String(format: "还款金额:%.2f", principal + interest)
    }
    
    func schedule_progress() -> String {
        if account.repayType == RepayType.RepayAllAtLast.rawValue {
            return String(format: "%d/%d", order,1)
        }
        return String(format: "%d/%d", order,account.timeSpan)
    }
    
    func schedule_state() -> String {
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