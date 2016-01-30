//
//  NKComposeController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKComposeController: NKBaseTableViewController {
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "save")
        
        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "cell")
        self.tableView.registerNib(UINib(nibName: "NKInvestAmoutCell", bundle: nil), forCellReuseIdentifier: "investAmount")
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("investAmount") as? NKInvestAmoutCell
            
            return cell!

        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell! 
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case  0:
            self.navigationController?.pushViewController(NKPlatformController(), animated: true)
        default:
            break
        }
        
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
