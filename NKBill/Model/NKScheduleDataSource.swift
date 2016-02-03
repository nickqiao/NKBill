//
//  NKScheduleModel.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation
import RealmSwift

enum NKScheduleDataSource: NKScheduleControllerDataSource {
    case Overdue
    case Passed
    case Wating
    var items: [(String, Results<NKItem>)]  {
        switch self {
        case .Overdue:
            return [("", NKLibraryAPI.sharedInstance.getOverdueItems())]
        case .Passed:
            return [("", NKLibraryAPI.sharedInstance.getPassedItems())]
        case .Wating:
            return f1()
        }
    }
    
    var afterAmonth: (String, Results<NKItem>) {
        return ("一个月后",NKLibraryAPI.sharedInstance.getAfterAmonthWatingItems())
    }
    
    var today: (String, Results<NKItem>) {
        return ("今天",NKLibraryAPI.sharedInstance.getTodayWatingItems())
    }
    
    var inAmonth: (String, Results<NKItem>) {
        return ("一个月内",NKLibraryAPI.sharedInstance.getInAmonthWatingItems())
    }
    
    var before: (String, Results<NKItem>) {
        return ("待处理",NKLibraryAPI.sharedInstance.getBeforeWatingItems())
    }
    
    func f1()-> [(String, Results<NKItem>)] {
        var x :[(String, Results<NKItem>)] = []
        
        if before.1.count > 0 {
            x.append(before)
        }
        
        if today.1.count > 0 {
            x.append(today)
        }
        
        if inAmonth.1.count > 0 {
            x.append(inAmonth)
        }
        
        if afterAmonth.1.count > 0 {
            x.append(afterAmonth)
        }
        return x
    }
}
