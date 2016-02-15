//
//  NKMoreController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKMoreController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allowsNotification() ? 2 : 1
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("more")
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                cell?.textLabel?.text = "接收新消息通知"
                if allowsNotification() == true {
                    cell?.detailTextLabel?.text = "已开启"
                }else {
                    cell?.detailTextLabel?.text = "已关闭"
                }
                
                return cell!
            }
            
            cell?.textLabel?.text = "设置通知时间"
            cell?.detailTextLabel?.text = ""
            cell?.accessoryType = .DisclosureIndicator
            return cell!
        }
       
        cell?.textLabel?.text = "欢迎留言QQ"
        cell?.detailTextLabel?.text = "393533945"
        return cell!
        
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "如果您要关闭或开启微信的消息通知,请在iPhone的\"设置\"-\"通知\"功能中,找到应用程序更改"
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if allowsNotification() && indexPath.row == 1 {
            
            performSegueWithIdentifier("noticeTime", sender: nil)
            
        }
    }
    
}
