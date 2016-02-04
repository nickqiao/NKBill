//
//  NKChooseNoticeTimeController.swift
//  NKBill
//
//  Created by nick on 16/2/4.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKChooseNoticeTimeController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelection = false
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 24
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        cell.textLabel?.text = "\(indexPath.row)点"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        
        saveLocalNotice(indexPath.row)
    }

    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .None
        
    }
    
    private func saveLocalNotice(clock: Int) {
        let notification = UILocalNotification()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
     
        let now = formatter.dateFromString("15:00:00")
        notification.fireDate = now
        notification.timeZone = NSTimeZone.defaultTimeZone()
        
        notification.repeatInterval = .Day
       
        notification.alertBody = "这是一个新的通知";
        
        notification.soundName = UILocalNotificationDefaultSoundName;
     
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}
