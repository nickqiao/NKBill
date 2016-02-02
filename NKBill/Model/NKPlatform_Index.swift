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
        return "投资总额:\(sum)元"
    }
    
    func ratioString() -> String {
        
        return "投资占比:\(round(ratio * 100))%"
    }
    
}