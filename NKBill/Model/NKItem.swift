//
//  NKAccount_Record.swift
//  NKBill
//
//  Created by nick on 16/2/1.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation
import RealmSwift

enum State: String {
    case Overdue
    case Waiting
    case Passed
}

class NKItem: Object {
    
    dynamic var repayDate = NSDate()
    dynamic var interest = 0.0
    dynamic var principal = 0.0
    dynamic var sum = 0.0
    var account: [NKAccount] {
        return linkingObjects(NKAccount.self, forProperty: "items")
    }
    dynamic var state = State.Waiting.rawValue
    var stateEnum:State {
        get {
            return State(rawValue: state)!
        }
        
        set {
            state = newValue.rawValue
        }
    }
}

extension NKItem {
    
    func Item_name() -> String {
        return (account.first?.platform?.name)!
    }
    
    func Item_repayDate() -> String {
        return repayDate.NK_formatDate()
    }
    
    func Item_interest() -> String {
        return String(format: ".2f", interest)
    }
    
    func Item_principal() -> String {
        return String(format: ".2f", principal)
    }
    
    func Item_sum() -> String {
        return String(format: ".2f", principal + interest)
    }
    
    func Item_state() -> String {
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
