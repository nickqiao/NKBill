//
//  NKMoreController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKMoreController: UITableViewController {

    @IBOutlet weak var noticeSwitch: UISwitch!
    @IBAction func swichChangeValue(sender: AnyObject) {
        
        let sw = sender   as! UISwitch
        if sw.on == true {
            tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
        } else {
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeSwitch.on  == true ? 3 : 2;
    }
    
    
    
}
