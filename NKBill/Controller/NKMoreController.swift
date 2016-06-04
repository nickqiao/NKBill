//
//  NKMoreController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import StoreKit
import PasscodeLock

class NKMoreController: UITableViewController {

    private var sw : UISwitch =  UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        sw.addTarget(self, action: #selector(self.switchAcition(_:)), forControlEvents: .ValueChanged)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func switchAcition(sw : UISwitch) {
        
        if sw.on == true {
            PasscodeVcManager.sharedInstance.showSetcodeVc()
        }else {
            PasscodeVcManager.sharedInstance.showDeleteCodeVc()
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allowsNotification() ? 2 : 1
        }
        if section == 1 {
            return 1
        }
        return 2
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
        
        if indexPath.section == 1 {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "")
            cell.textLabel?.text = "设置密码"
            sw.on = UserDefaultsPasscodeRepository().hasPasscode
            cell.accessoryView = sw
            return cell
        }
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = "欢迎评分留言"
                cell?.detailTextLabel?.text = ""
                cell?.accessoryType = .DisclosureIndicator
            }
            
            if indexPath.row == 1 {
                cell?.textLabel?.text = "作者QQ"
                cell?.detailTextLabel?.text = "静水流:393533945"
            }

        }

        
        return cell!
        
    }

   
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "如果您要关闭或开启网贷笔记的消息通知,请在iPhone的\"设置\"-\"通知\"功能中,找到应用程序更改"
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if allowsNotification() && indexPath.row == 1 && indexPath.section == 0{
            
            performSegueWithIdentifier("noticeTime", sender: nil)
            
        }
        
        if (indexPath.section == 1) {
            if indexPath.row == 0 {
                let s = String(format: "http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1084361782&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8")
                UIApplication.sharedApplication().openURL(NSURL(string:s)!)
            }
          
        }
       
    }
    
}
