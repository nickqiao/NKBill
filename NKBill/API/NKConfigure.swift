//
//  NKConfigure.swift
//  NKBill
//
//  Created by nick on 16/2/2.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

/// 默认本地通知时间
let DefaultNoticeTime = 9

let FirstLaunchKey = "firstLaunch"

/// random number
func randomInRange(range: Range<Int>) -> Int {
    let count = UInt32(range.endIndex - range.startIndex)
    return  Int(arc4random_uniform(count)) + range.startIndex
}

func allowsNotification() -> Bool {
    let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
    if settings!.types == .None {
        return false
    }
   return true
}


