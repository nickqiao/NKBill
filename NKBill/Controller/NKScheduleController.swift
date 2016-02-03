//
//  NKScheduleController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit
import RealmSwift
protocol NKScheduleControllerDataSource {
    var items: [(String, Results<NKItem>)] { get }
}

class NKScheduleController: NKBaseViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let reuseIndentifier = "schedule"
    let cellNibName = "NKScheduleCell"
    
    var dataSource: NKScheduleControllerDataSource? {
        
        switch segment.selectedSegmentIndex {
        case 0:
            return NKScheduleDataSource.Wating
        case 1:
            return NKScheduleDataSource.Passed
        case 2:
            return NKScheduleDataSource.Overdue
        default:
            return NKScheduleDataSource.Wating
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerNib(UINib(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: reuseIndentifier)
        tableView.rowHeight = 64
        tableView.backgroundColor = NKBackGroudColor()
        segment.addTarget(self, action: "segmentChangeValue:", forControlEvents: .ValueChanged)
    }
    
    func segmentChangeValue(seg: UISegmentedControl) {
        tableView.reloadData()
    }
    
}

extension NKScheduleController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (dataSource?.items.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.items[section].1.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier) as! NKScheduleCell
        cell.item = dataSource?.items[indexPath.section].1[indexPath.row]

        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource?.items[section].0
    }
    
}

extension NKScheduleController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}