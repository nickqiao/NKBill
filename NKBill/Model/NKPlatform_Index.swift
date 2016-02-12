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
        
        return "\(round(ratio * 100))%"
    }
    
}