//
//  NKOverdueController.swift
//  NKBill
//
//  Created by nick on 16/6/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKOverdueController: NKBaseViewController {

    private lazy var tableView : NKBaseTableView = {
        var tv = NKBaseTableView(frame: self.view.frame, style: .Grouped)
        tv.backgroundColor = Constant.Color.BGColor
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private var items = NKLibraryAPI.sharedInstance.getOverdueItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.registerCellNib(NKScheduleCell)
    }
    
}

extension NKOverdueController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NKScheduleCell.identifier) as! NKScheduleCell
        cell.item = items[indexPath.row]
        return cell
    }
    
}

extension NKOverdueController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        UIAlertManager.showAcitonSheet(items[indexPath.row])
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NKScheduleCell.height()
    }
}
