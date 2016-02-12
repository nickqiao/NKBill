//
//  NKBaseTabBarController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.tabBar.items![0].selectedImage = UIImage(named: "index")
    }

    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.title == "记一笔" {
            
            performSegueWithIdentifier("compose", sender: nil)
            
        }
    }
    
}

extension NKTabBarController: UITabBarControllerDelegate {
  
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers![2] {
            return false
        }else {
            return true
        }
    }
    
}


