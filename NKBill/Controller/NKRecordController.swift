//
//  NKRecordController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift

protocol NKRecordControllerDatasource {
    var title: String { get }
    var accountsArray: Results<NKAccount> { get }
}

struct defaultDatasource: NKRecordControllerDatasource {
    var title: String {
        return "投资记录"
    }
    
    var accountsArray: Results<NKAccount> {
        return NKLibraryAPI.sharedInstance.getAccountsByDate()
    }
}

class NKRecordController: UITableViewController {
    
    var dataSource: NKRecordControllerDatasource?
    
    var selectedAccount: NKAccount!
    
    let reuseIdentifier = "record"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let x = dataSource {
            title = x.title
        }else {
            dataSource = defaultDatasource()
            title = dataSource?.title
        }
        tableView.backgroundColor = NKBackGroudColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVc = segue.destinationViewController as! NKDetailController
        detailVc.account = selectedAccount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.accountsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKAccountCell
        let account = dataSource!.accountsArray[indexPath.row]
        configureCell(cell, account: account)
        
        return cell
    }
    
    private func configureCell(cell:NKAccountCell, account:NKAccount) {
        
        cell.platNameLabel.text = account.record_name()
        cell.investLabel.text = account.record_invest()
        cell.dateLabel.text = account.record_date()
        cell.rateLabel.text = account.record_rate()
        
        cell.circleProgressView.value = CGFloat(account.progress())
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedAccount = dataSource!.accountsArray[indexPath.row]
        return indexPath
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            NKLibraryAPI.sharedInstance.deleteAccount(dataSource!.accountsArray[indexPath.row])
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        }
    }

    
}
