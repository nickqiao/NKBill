//
//  NKAccount.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

enum TimeType {
    case MONTH
    case DAY
}

enum RepaymentType {
    case AverageCapital
    case InterestByMonth
    case InterestByDay
    case RepayAllAtLast
}

class NKAccount: NSObject {
    
    var platform: NKPlatform?
    var investAmount = 0.0
    var rate: Float = 0.0
    var timeType: TimeType = .MONTH
    var investLength = 0
    var date: NSDate = NSDate(timeIntervalSinceNow: 0.0)
    var repaymentType: RepaymentType = .AverageCapital
    
}
