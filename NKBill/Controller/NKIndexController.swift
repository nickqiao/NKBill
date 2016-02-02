//
//  NKIndexController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIndexController: NKBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var platforms: [NKPlatform]  {
       return NKLibraryAPI.sharedInstance.getInvestedPlatforms()
    }
    
    let reuseIdentifier = "index"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "NKIndexCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
 
}

extension NKIndexController: UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return platforms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NKIndexCell
        let plat = platforms[indexPath.row]
        cell.orderLabel.text = "\(indexPath.row + 1)"
        cell.platLabel.text = plat.name
        cell.ratioLabel.text = plat.ratioString()
        cell.investLabel.text = plat.platSum()
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "投资平台"
    }
    
}