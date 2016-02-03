//
//  NKConfigure.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

/// random number
func randomInRange(range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return  Int(arc4random_uniform(count)) + range.startIndex
}

func NKBackGroudColor() ->UIColor {
    return UIColor(colorLiteralRed: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)
}
