//
//  NKAccount.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift

enum TimeType: String {
    case MONTH
    case DAY
}

enum RepayType:String {
    case AverageCapital
    case InterestByMonth
    case InterestByDay
    case RepayAllAtLast
}

class NKAccount: Object {
    
    dynamic var id = ""
    dynamic var platform: NKPlatform?
    dynamic var invest = 0
    dynamic var rate = 0.0
    dynamic var timeSpan = 0
    dynamic var created: NSDate = NSDate(timeIntervalSinceNow: 0.0)
    let items = List<NKItem>()
    
    dynamic var timeType = TimeType.MONTH.rawValue
    var timeTypeEnum: TimeType {
        get {
            return TimeType(rawValue: timeType)!
        }
        
        set {
            timeType = newValue.rawValue
        }
    }
    
    dynamic var repayType = RepayType.AverageCapital.rawValue
    var repayTypeEnum:RepayType {
        get {
            return RepayType(rawValue: repayType)!
        }
        
        set {
            repayType = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

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




