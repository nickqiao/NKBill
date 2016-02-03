//
//  NKPlatformController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

let reuseIndentifier = "platform"

class NKPlatformController: UITableViewController {

    private lazy var platforms = NKLibraryAPI.sharedInstance.getPlatforms()
    
    
    var selectedPlatform: NKPlatform!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return platforms.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier)
        let p = platforms[indexPath.row]
        cell?.textLabel?.text = p.name
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath {
        selectedPlatform = platforms[indexPath.row]
        return indexPath
    }
    

}
