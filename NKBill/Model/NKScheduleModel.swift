//
//  NKScheduleModel.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation
import RealmSwift
struct NKScheduleModel: ScheduleControllerDataSource {
    
    var afterAmonth: Results<NKItem> {
        return NKAccountManager().getOneMonthLaterWatingItems()
    }
    
    var today: Results<NKItem> {
        return NKAccountManager().getTodayWatingItems()
    }
    
    var inAmonth: Results<NKItem> {
        return NKAccountManager().getInAmonthWatingItems()
    }
    
    var before: Results<NKItem> {
        return NKAccountManager().getBeforeWatingItems()
    }
    
    var kind: State {
        return State.Waiting
    }
    
    var sections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return before.count
    }
    
    var items: [NKItem] {
        return before.map({ $0 })
    }
    
}