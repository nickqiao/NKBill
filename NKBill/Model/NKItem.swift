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
    
    dynamic var order = 0
    dynamic var repayDate = NSDate()
    dynamic var interest = 0.0
    dynamic var principal = 0.0
    dynamic var sum = 0.0
    dynamic var account: NKAccount!
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


