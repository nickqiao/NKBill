//
//  NKAccount_Compose.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation


extension NKAccount {
    
    func compose_name() -> (String,String) {
        return ("投资平台",platform.name)
    }
    
    func compose_invest() -> (String,String)  {
        return ("投资金额","¥\(invest)")
    }
    
    func compose_rate() -> (String,String) {
        if rate == 0.0 {
            return ("年化利率", "")
        }
        if rate > 0.5 {
            return ("年化利率", "60%")
        }
        
        return ("年化利率", "\(rate * 100)%")
        
    }
    
    func compose_timeSpan() -> (String,String) {
        switch timeTypeEnum {
        case .DAY:
            return ("投资期限","\(timeSpan)天")
        case .MONTH:
            return ("投资期限","\(timeSpan)个月")
        }
    }
    
    func compose_created() -> (String,String) {
        return ("起息日",created.NK_formatDate())

    }
    
    func compose_repayType() -> (String,String) {
        switch repayTypeEnum {
        case .AverageCapital:
            return ("还款方式:","等额本息")
        case .InterestByMonth:
            return ("还款方式:","按月计息,到期还本")
        case .InterestByDay:
            return ("还款方式:","按日计息,到期还本")
        case .RepayAllAtLast:
            return ("还款方式:","到期还本息")
        }
    }
    
    
    
}