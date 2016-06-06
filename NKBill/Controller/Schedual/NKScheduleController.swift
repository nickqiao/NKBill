//
//  NKScheduleController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKScheduleController : WMPageController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.menuViewStyle = .Foold
        
        self.menuHeight = 44
        self.menuItemWidth = 80
        self.progressColor = Constant.Color.ThemeBlueColor
        self.menuBGColor = Constant.Color.BGColor
        self.titleSizeNormal = 14.0
        self.titleSizeSelected = 18.0
        self.titleColorNormal = UIColor.flatGrayColor()
        self.titleColorSelected = UIColor.flatWhiteColor()
        self.progressHeight = 3.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "回款计划"
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

