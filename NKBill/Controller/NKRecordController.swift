//
//  NKRecordController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift

class NKRecordController: UITableViewController {

    var accounts:[NKAccount] {
        return NKLibraryAPI.sharedInstance.getAccountsByDate()
    }
    
    let reuseIdentifier = "record"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerNib(UINib(nibName: "NKAccountCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        self.tableView.rowHeight = 64
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKAccountCell
        let account = accounts[indexPath.row]
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
