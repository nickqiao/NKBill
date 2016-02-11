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
    @IBAction func addPlatform(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "添加平台", message: nil , preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { nameField -> Void in
            nameField.placeholder = "平台名称"
        }
        alert.addTextFieldWithConfigurationHandler { descField -> Void in
            descField.placeholder = "平台备注"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil )
        let sureAction = UIAlertAction(title: "确定", style: .Default) { a -> Void in
            
            let textfield = alert.textFields![0]
            
            if textfield.text?.characters.count > 0 {
                
                let p = NKPlatform()
                p.name = textfield.text!
                NKLibraryAPI.sharedInstance.addPlatform(p)
                self.tableView.reloadData()
                
            }
           
        }
        
        alert.addAction(cancelAction)
        alert.addAction(sureAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
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
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            NKLibraryAPI.sharedInstance.deletePlatform(platforms[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }

}
