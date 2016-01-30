//
//  NKBaseTableViewController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let refresh = UIRefreshControl()
        
        self.tableView.addSubview(refresh)
        refresh.addTarget(self, action: "loadNewData", forControlEvents: .ValueChanged)
        
    }

    func loadNewData() {
        print("加载新数据")
    }
    
}
