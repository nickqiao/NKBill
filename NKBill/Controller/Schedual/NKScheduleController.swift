//
//  NKScheduleController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleController : WMPageController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.menuViewStyle = .Foold
        
        self.menuHeight = 64
        self.menuItemWidth = 120
        //self.progressColor = UIColor(hexString: "#a3dff0")
        self.menuBGColor = Constant.Color.ThemeBlueColor
        self.titleSizeNormal = 14.0
        self.titleSizeSelected = 18.0
        //self.titleColorNormal = UIColor(hexString: "#d3d9db")
        //self.titleColorSelected = UIColor(hexString: "#839ca3")
        self.progressHeight = 3.0
 
    }

    override func numbersOfChildControllersInPageController(pageController: WMPageController!) -> Int {
        return Constant.Schedual.titles.count
    }
    
    override func pageController(pageController: WMPageController!, viewControllerAtIndex index: Int) -> UIViewController! {
        
        if index == 0 {
            return NKWaitingController.WaitingController()
        }
        
        if index == 1 {
            return NKPassedController()
        }
        
        return NKOverdueController()
        
    }
    
    override func pageController(pageController: WMPageController!, titleAtIndex index: Int) -> String! {
        return Constant.Schedual.titles[index]
    }

        
}

