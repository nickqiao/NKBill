//
//  NKIndexController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIndexController: NKBaseViewController {

    var tableView = UITableView(frame: CGRectMake(0, 80, 400, 300), style: .Grouped)
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: "load" , forControlEvents: .ValueChanged)
    }
    
    func load() {
        print("即使对方拉空间")
    }
    
}

extension NKIndexController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
}