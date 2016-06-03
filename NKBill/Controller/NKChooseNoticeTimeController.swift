//
//  NKChooseNoticeTimeController.swift
//  NKBill
//
//  Created by nick on 16/2/4.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKChooseNoticeTimeController: UITableViewController {

    lazy var selectedIndex = NSUserDefaults.standardUserDefaults().integerForKey(Constant.Notice.NoticeTimeKey)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:IBAction
    @IBAction func save(sender: AnyObject) {
        saveNoticeTime()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func back(sender: UIBarButtonItem) {
        
        if selectedIndex != NSUserDefaults.standardUserDefaults().integerForKey(Constant.Notice.NoticeTimeKey) {
            let al = UIAlertController(title: "是否保存修改的通知时间", message: nil, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: {[unowned self] (_) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
                })
            
            let sureAction = UIAlertAction(title: "确定", style: .Default, handler: { [unowned self](_) -> Void in
                self.saveNoticeTime()
                self.navigationController?.popViewControllerAnimated(true)
                })
            al.addAction(cancelAction)
            al.addAction(sureAction)
            presentViewController(al, animated: true, completion: nil)
        }else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 24
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        if indexPath.row == selectedIndex {
            cell.accessoryType = .Checkmark
        }else {
            cell.accessoryType = .None
        }
        cell.textLabel?.text = "\(indexPath.row)点"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (selectedIndex == indexPath.row) {
            return
        }
        
        let oldIndexPath = NSIndexPath(forRow: selectedIndex, inSection: 0)
        
        let  newCell = tableView.cellForRowAtIndexPath(indexPath)
        
        if (newCell!.accessoryType == .None) {
            newCell?.accessoryType = .Checkmark;
            selectedIndex = indexPath.row
        }
        
        let oldCell = tableView.cellForRowAtIndexPath(oldIndexPath);
        if (oldCell!.accessoryType == .Checkmark) {
            oldCell?.accessoryType = .None;
        }
        
    }

    // MARK:Private
    private func saveNoticeTime() {
        NSUserDefaults.standardUserDefaults().setInteger(selectedIndex, forKey: Constant.Notice.NoticeTimeKey)
        NKNotificationManager.updateLocalNotifications()
    }
}
