//
//  NKPrint.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

func println(object: Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}