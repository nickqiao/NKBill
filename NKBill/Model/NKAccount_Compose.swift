//
//  NKAccount_Compose.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation


extension NKAccount {
    
    func compose_name() -> String {
        if let n = platform?.name {
            return n
        }else {
            return ""
        }
        
    }
    
    func compose_invest() -> String {
        return "¥\(invest)"
    }
    
    func compose_rate() -> String {
        if rate == 0.0 {
            return ""
        }
        if rate > 0.5 {
            return "60%"
        }
        
        return "\(rate * 100)%"
        
    }
    
    func compose_timeSpan() -> String {
        switch timeTypeEnum {
        case .DAY:
            return "\(timeSpan)天"
        case .MONTH:
            return "\(timeSpan)个月"
        }
    }
    
    func compose_created() -> String {
        return created.NK_formatDate()
    }
    
    func compose_repayType() -> String {
        switch repayTypeEnum {
        case .AverageCapital:
            return "等额本息"
        case .InterestByMonth:
            return "按月计息,到期还本"
        case .InterestByDay:
            return "按日计息,到期还本"
        case .RepayAllAtLast:
            return "到期还本息"
        }
    }
    
    
    
}