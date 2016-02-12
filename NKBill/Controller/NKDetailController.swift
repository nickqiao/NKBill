//
//  NKDetailController.swift
//  NKBill
//
//  Created by nick on 16/2/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKDetailController: UITableViewController {

    var account: NKAccount!
    
    let reuseIndentifier = "detail"
    let detailItemIndentifier = "item"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NKLibraryAPI.sharedInstance.updateUIWith(String(self)) { [unowned self]() -> Void in
            self.tableView.reloadData()
        }

    }

    deinit {
        NKLibraryAPI.sharedInstance.removeClosure(String(self))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            let nav = segue.destinationViewController as! NKNavigationController
            if let composeVc = nav.topViewController as? NKComposeController {
                composeVc.account = account
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 7
        }
        
        return account.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier(detailItemIndentifier) as! NKDetailItemCell
            cell.item = account.items[indexPath.row]
            return cell
        }
        
       
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier, forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(12)
        cell.detailTextLabel?.font = UIFont.systemFontOfSize(12)

        if indexPath.row == 0 {
            cell.textLabel?.text = account.compose_name().0
            cell.detailTextLabel?.text = account.compose_name().1
        }
        if indexPath.row == 1 {
            cell.textLabel?.text = account.compose_invest().0
            cell.detailTextLabel?.text = account.compose_invest().1
        }
        if indexPath.row == 2 {
            cell.textLabel?.text = account.compose_rate().0
            cell.detailTextLabel?.text = account.compose_rate().1
        }
        
        if indexPath.row == 3 {
            cell.textLabel?.text = account.compose_timeSpan().0
            cell.detailTextLabel?.text = account.compose_timeSpan().1

        }
        
        if indexPath.row == 4 {
            cell.textLabel?.text = account.compose_created().0
            cell.detailTextLabel?.text = account.compose_created().1
            
        }
        if indexPath.row == 5 {
            cell.textLabel?.text = account.compose_repayType().0
            cell.detailTextLabel?.text = account.compose_repayType().1
            
        }

        if indexPath.row == 6 { //备注
            cell.textLabel?.text = account.compose_desc().0
            cell.detailTextLabel?.text = account.compose_desc().1
        }
        
        return cell
        
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return NKDetailHeader.detailHeader()
        }
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }
        return 0
    }
    
}
