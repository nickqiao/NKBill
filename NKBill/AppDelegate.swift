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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        print("\(NSHomeDirectory())")

        customAppearce()
        updateBadgeValue()
        configureLocalNotice()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateBadgeValue", name: updateBadgeValueNotification, object: nil)
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
       
    }
    
    
    private func customAppearce() {
        
        // Global Tint Color
        
        window?.tintColor = UIColor.flatBrownColor()
        window?.tintAdjustmentMode = .Normal
        
        // NavigationBar Item Style
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatCoffeeColor()], forState: .Normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.flatGreenColor().colorWithAlphaComponent(0.3)], forState: .Disabled)
        
        // NavigationBar Title Style
        
        let shadow: NSShadow = {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.lightGrayColor()
            shadow.shadowOffset = CGSizeMake(0, 0)
            return shadow
        }()
        
        let textAttributes = [
            NSForegroundColorAttributeName: UIColor.flatBlackColor(),
            NSShadowAttributeName: shadow,
            NSFontAttributeName: UIFont.boldSystemFontOfSize(17)
        ]
        
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().barTintColor = UIColor.flatOrangeColor()
       
        
        // TabBar
        
        //UITabBar.appearance().backgroundImage = UIImage(named:"white")
        //UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().tintColor = UIColor.flatBlackColor()
        UITabBar.appearance().barTintColor = UIColor.flatOrangeColor()
        //UITabBar.appearance().translucent = false
    }

    // 更新badgeValue
    func updateBadgeValue() {
        
        let tabVc = window?.rootViewController as! NKTabBarController
        let tbItem = tabVc.tabBar.items![1]
        let num = NKLibraryAPI.sharedInstance.getUnsolvedItemsCount()
        if num > 0 {
            tbItem.badgeValue = "\(num)"
        }else {
            tbItem.badgeValue = nil
        }
    
    }
    
    private func configureLocalNotice() {
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Badge,.Alert,.Sound], categories: nil))
        if NSUserDefaults.standardUserDefaults().boolForKey(FirstLaunchKey) == false {
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: FirstLaunchKey)
            NSUserDefaults.standardUserDefaults().setInteger(9, forKey: NoticeTimeKey)
            NKNotificationManager.updateLocalNotifications()
            
        }
    }
    
}

