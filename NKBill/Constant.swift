//
//  Constant.swift
//  NKBill
//
//  Created by nick on 16/6/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import Foundation

struct Constant {
    
    
    
    struct Login {
        static let FirstLaunchKey = "firstLaunch"
        // 登录过
        static var Logined : Bool {
           return NSUserDefaults.standardUserDefaults().boolForKey(Constant.Login.FirstLaunchKey)
        }
    }
    
    struct Color {
        static let BGColor = UIColor(colorLiteralRed: 0.937255, green: 0.937255, blue: 0.956863, alpha: 1.0)
        static let ThemeBlueColor = UIColor(colorLiteralRed: 0.0, green: 170.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
    }
    
    struct Font {
        static let cellFont = UIColor(colorLiteralRed: 92, green: 94, blue: 102, alpha: 1.0)
    }
    
    // 回款计划模块
    struct Schedual {
        static let titles = ["待还","已还","逾期"]
    }
    
    struct Notice {
        static let DefaultNoticeTime = 9
        static let NoticeTimeKey = "NoticeTime"
    }
    
}

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


