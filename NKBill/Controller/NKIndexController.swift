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
    
    @IBOutlet weak var passedInterestLabel: UILabel!
    @IBOutlet weak var weightRateLabel: UILabel!
    @IBOutlet weak var investLabel: UILabel!
    @IBOutlet weak var watingLabel: UILabel!
    
    var selectedPlatform: NKPlatform!
    private lazy var platforms = NKLibraryAPI.sharedInstance.getInvestedPlatforms()
    
    let reuseIdentifier = "index"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "NKIndexCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        tableView.backgroundColor = NKBackGroundColor()
        NKLibraryAPI.sharedInstance.updateUIWith(String(self)) {[unowned self] () -> Void in
            self.tableView.reloadData()
        }

    }
    
    deinit {
        NKLibraryAPI.sharedInstance.removeClosure(String(self))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        passedInterestLabel.animate(from: 0, to: Int(NKLibraryAPI.sharedInstance.getPassedInterest()))
        //watingLabel.text = String(format: "%.2f",NKLibraryAPI.sharedInstance.getWatingInterest())
        watingLabel.animate(from: 0, to: Int(NKLibraryAPI.sharedInstance.getWatingInterest()))
        investLabel.animate(from: 0, to: NKLibraryAPI.sharedInstance.getSumInvest())
        weightRateLabel.animate(from: 0, to:Int( NKLibraryAPI.sharedInstance.getWeightRate() * 100))
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let recordVc = segue.destinationViewController as! NKRecordController
        
        recordVc.dataSource = selectedPlatform
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

extension NKIndexController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedPlatform = platforms[indexPath.row]
        performSegueWithIdentifier("indexToRecord", sender: nil)
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
