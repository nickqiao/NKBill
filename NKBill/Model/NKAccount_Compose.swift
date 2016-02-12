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
        return ("投资金额","\(invest)")
    }
    
    func compose_rate() -> (String,String) {
        if rate == 0.0 {
            return ("年化利率", "")
        }
        
        return ("年化利率", "\(rate * 100)")
        
    }
    
    func compose_timeSpan() -> (String,String) {
        switch timeType {
        case TimeType.DAY.rawValue:
            return ("投资期限","\(timeSpan)")
        case TimeType.MONTH.rawValue:
            return ("投资期限","\(timeSpan)")
        default:
            return ("","")
        }
    }
    
    func compose_created() -> (String,String) {
        return ("起息日",created.NK_formatDate())

    }
    
    func compose_repayType() -> (String,String) {
        switch repayType {
        case RepayType.AverageCapital.rawValue:
            return ("还款方式:","等额本息")
        case RepayType.InterestByMonth.rawValue:
            return ("还款方式:","按月计息,到期还本")
        case RepayType.InterestByDay.rawValue:
            return ("还款方式:","按日计息,到期还本")
        case RepayType.RepayAllAtLast.rawValue:
            return ("还款方式:","到期还本息")
        default:
            return ("","")
        }
    }
    
    func compose_desc() -> (String,String) {
            return ("项目备注","\(desc)")
    }
    
}