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
    var accounts: Results<NKAccount> { get }
}

class NKRecordController: UITableViewController {
    
    var dataSource: NKRecordControllerDatasource?
    
    var selectedAccount: NKAccount!
    
    let reuseIdentifier = "record"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let _ = dataSource {
            
        }else {
            dataSource =  NKRecordDatasource.placeholder
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
        return dataSource!.accounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKAccountCell
        let account = dataSource!.accounts[indexPath.row]
        configureCell(cell, account: account)
        
        return cell
    }
    
    private func configureCell(cell:NKAccountCell, account:NKAccount) {
        
        cell.platNameLabel.text = account.record_name()
        cell.investLabel.text = account.record_invest()
        cell.dateLabel.text = account.record_date()
        cell.rateLabel.text = account.record_rate()
        cell.progressBar.progress = account.record_progress()
        cell.progressLabel.text = account.record_progressString()
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedAccount = dataSource!.accounts[indexPath.row]
        return indexPath
    }
    
}
