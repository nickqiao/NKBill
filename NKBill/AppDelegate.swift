//
//  AppDelegate.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIScreen.mainScreen().bounds
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = UIColor.whiteColor()
        self.addSonControllers()
        
        return true
    }
    
    private func addSonControllers() {
        let indexVc = NKIndexController()
        let nav1 = NKBaseNavigationController(rootViewController: indexVc)
         nav1.tabBarItem.title = "首页"
        
        let scheduleVc = NKScheduleController()
        let nav2 = NKBaseNavigationController(rootViewController: scheduleVc)
        nav2.tabBarItem.title = "待办事项"
        
        let composeVc = NKComposeController()
        let nav3 = NKBaseNavigationController(rootViewController: composeVc)
        nav3.tabBarItem.title = "记一笔"
        let recordVc = NKRecordController()

        let nav4 = NKBaseNavigationController(rootViewController: recordVc)
        nav4.tabBarItem.title = "投资记录"
        
        
        let moreVc = NKMoreController()
        let nav5 = NKBaseNavigationController(rootViewController: moreVc)
        nav5.tabBarItem.title = "更多"
        
        let tabVc = NKBaseTabBarController()
        tabVc.viewControllers = [nav1,nav2,nav3,nav4,nav5]
        self.window?.rootViewController = tabVc
        self.window?.makeKeyAndVisible()
    }

    
}

