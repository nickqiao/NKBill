//
//  NKPlatformController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

let reuseIndentifier = "platform"

protocol PlatformControllerDelegate {
    func platformControllerSelectPlatform(platform:NKPlatform)
}

class NKPlatformController: NKBaseTableViewController {

    var platforms:[NKPlatform] = []
    
    var delegate: PlatformControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: reuseIndentifier)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return platforms.count
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier)
        
        cell?.textLabel?.text = "ddafds\(indexPath.row)"
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.platformControllerSelectPlatform(platforms[indexPath.row])
        
    }
    

}
