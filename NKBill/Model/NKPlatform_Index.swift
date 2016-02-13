//
//  NKPlatform_Index.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

extension NKPlatform {
    
    func platSum() -> String {
        return "\(sum)元"
    }
    
    func ratioString() -> String {
        
        return String(format: "占比%.0f%%", round(ratio * 100000) / 1000  )
    }
    
    func numbersOfAccounts() -> String {
        return " \(accounts.count)笔 "
    }
    
}