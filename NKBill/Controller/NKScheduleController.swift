//
//  NKScheduleController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

protocol ScheduleControllerDataSource {
    var kind: State { get }
    var sections: Int { get }
    var numberOfRows: Int { get }
    var items: [NKItem] { get }
}

extension ScheduleControllerDataSource {
    var  sections :Int {
        return 1
    }
    var kind: State {
        return State.Waiting
    }
    
}

class NKScheduleController: NKBaseViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: ScheduleControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.registerClass(UITableView.self , forCellReuseIdentifier: "1")
    }
    
}

extension NKScheduleController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (dataSource?.sections)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.numberOfRows)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("1")
        let item = dataSource?.items[indexPath.row]
        cell?.textLabel?.text = item?.account.first?.platform?.name
        return cell!
    }
    
}

extension NKScheduleController: UITableViewDelegate {
    
}