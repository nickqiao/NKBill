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
    
    var selectedItem: NKItem!
    
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
        tableView.backgroundColor = NKBackGroundColor()
        segment.addTarget(self, action: "segmentChangeValue:", forControlEvents: .ValueChanged)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        
        selectedItem = dataSource?.items[indexPath.section].1[indexPath.row]
        
        showActionSheet()
    }
    
    func showActionSheet() {
        
        let sheet = UIAlertController(title: "处理该笔还款状态", message: nil, preferredStyle: .ActionSheet)
        
        let watingHandler = UIAlertAction(title: "未还", style: .Default){(_) -> Void in
            NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Waiting)
            self.tableView.reloadData()
        }

        let passedHandler = UIAlertAction(title: "已还", style: .Default){(_) -> Void in
             NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Passed)
            self.tableView.reloadData()
        }

        let overDueHandler = UIAlertAction(title: "逾期", style: .Default){(_) -> Void in
            NKLibraryAPI.sharedInstance.changeItemState(self.selectedItem, toState: .Overdue)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)

        
        switch selectedItem.state {
            
        case State.Waiting.rawValue:
            if selectedItem.repayDate.timeIntervalSince1970 < NSDate().timeIntervalSince1970 {
                sheet.addAction(passedHandler)
                sheet.addAction(overDueHandler)
                sheet.addAction(cancelAction)
                presentViewController(sheet, animated: true, completion: nil)
            }else {
                sheet.addAction(passedHandler)
                sheet.addAction(cancelAction)
                presentViewController(sheet, animated: true, completion: nil)

            }
        case State.Passed.rawValue:
             sheet.addAction(watingHandler)
             sheet.addAction(overDueHandler)
             sheet.addAction(cancelAction)
            presentViewController(sheet, animated: true, completion: nil)
        case State.Overdue.rawValue:
            sheet.addAction(watingHandler)
            sheet.addAction(passedHandler)
            sheet.addAction(cancelAction)
            presentViewController(sheet, animated: true, completion: nil)
        default:
            break
            
        }
        
    }
    
}