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
        return (account.first?.platform?.name)!
    }
    
    func Detail_repayDate() -> String {
        return String(format: "  %.2f", repayDate.NK_formatDate())
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
        switch stateEnum {
        case .Overdue:
            return "逾期"
        case .Passed:
            return "已还"
        case .Waiting:
            return "待还"
        }
    }
    
}
