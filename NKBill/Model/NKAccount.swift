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
    dynamic var platform: NKPlatform!
    dynamic var invest = 0
    dynamic var rate = 0.0
    dynamic var timeSpan = 0
    dynamic var created: NSDate = NSDate(timeIntervalSinceNow: 0.0)
    let items = List<NKItem>()
    dynamic var desc = ""
    
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




