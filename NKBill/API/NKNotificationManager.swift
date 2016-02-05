//
//  NKNotificationManager.swift
//  NKBill
//
//  Created by nick on 16/2/5.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKNotificationManager {
    
    static func updateLocalNotifications() {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        let items = NKLibraryAPI.sharedInstance.getNeedNoticeItems()
        let clock = NSUserDefaults.standardUserDefaults().integerForKey(NoticeTimeKey)
        
        items.forEach { item -> () in
            
            let s = String(format: "今日%@回款%@元", item.schedule_platName(),item.Detail_sum())
            presentLocalNotice(item.repayDate.NK_zeroMorning().NK_dateByAddingHours(clock), alertString: s)
        }
        
    }
    
    private static func presentLocalNotice(fireDate:NSDate, alertString: String) {
        let notification = UILocalNotification()
        notification.fireDate = fireDate
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertBody = alertString;
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
 
}