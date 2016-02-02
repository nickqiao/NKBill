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
        
        
       // print(NKLibraryAPI.sharedInstance.getWatingInterest())
        //print(NKLibraryAPI.sharedInstance.getInvestedPlatforms())
        
//        print(NKLibraryAPI.sharedInstance.getSumInvest())
//        print(NKLibraryAPI.sharedInstance.getWaitingItems())
//        print(NKLibraryAPI.sharedInstance.getPassedInterest())
       // print(NKLibraryAPI.sharedInstance.getAccountsByDate())
      //  print(NKLibraryAPI.sharedInstance.getInvestedPlatforms())
        
        
       customAppearce()
        
        //UIScreen.mainScreen().bounds
        //self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //self.window?.backgroundColor = UIColor.whiteColor()
        //self.addSonControllers()
        
        return true
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

    
    
}

