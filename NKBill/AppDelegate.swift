//
//  AppDelegate.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import Chameleon
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var badgeNum: Int {
        return NKLibraryAPI.sharedInstance.getUnsolvedItemsCount()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        print("\(NSHomeDirectory())")
        // 设置界面颜色
        customAppearce()
        // 配置本地通知
        configureLocalNotice()

        self.updateBadgeValue()
        
        NKLibraryAPI.sharedInstance.updateUIWith(String(self)) { () -> Void in
            self.updateBadgeValue()
            NKNotificationManager.updateLocalNotifications()
        }
        
        return true
    }
    
    deinit {
        NKLibraryAPI.sharedInstance.removeClosure(String(self))
    }
    
    private func customAppearce() {
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        window?.tintColor = UIColor.flatBlackColor()
        // NavigationBar Item Style
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatBlackColor()], forState: .Normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatBlackColor()], forState: .Disabled)
        
        let shadow: NSShadow = {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.clearColor()
            shadow.shadowOffset = CGSizeMake(0, 0)
            return shadow
        }()
        let textAttributes = [
            NSForegroundColorAttributeName: UIColor.flatBlackColor(),
            NSShadowAttributeName: shadow,
            NSFontAttributeName: UIFont.boldSystemFontOfSize(17)
        ]

        UINavigationBar.appearance().titleTextAttributes = textAttributes
        //UINavigationBar.appearance().barTintColor = NKBlueColor()
        
        UITabBar.appearance().tintColor = NKBlueColor()
        UITabBar.appearance().barTintColor = UIColor.flatWhiteColor()
    
        
    }

    // 更新badgeValue
    func updateBadgeValue() {
        
        let tabVc = window?.rootViewController as! NKTabBarController
        let tbItem = tabVc.tabBar.items![1]
        if badgeNum > 0 {
            tbItem.badgeValue = "\(badgeNum)"
        }else {
            tbItem.badgeValue = nil
        }
    
    }
    
    private func configureLocalNotice() {
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Badge,.Alert,.Sound], categories: nil))
        if NSUserDefaults.standardUserDefaults().boolForKey(FirstLaunchKey) == false {
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: FirstLaunchKey)
            NSUserDefaults.standardUserDefaults().setInteger(DefaultNoticeTime, forKey: NoticeTimeKey)
        }
    }
    
}

