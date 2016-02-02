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
    }

    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.title == "记一笔" {
            
            self.presentViewController( NKNavigationController(rootViewController: NKComposeController.composeController()),animated: true, completion: nil)
            
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


