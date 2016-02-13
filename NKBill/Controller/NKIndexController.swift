//
//  NKIndexController.swift
//  NKBill
//
//  Created by nick on 16/1/30.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKIndexController: NKBaseViewController {

    @IBOutlet weak var header: UIView!
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
        
        configureHeader()

        // Do any additional setup after loading the view.
        tableView.registerNib(UINib(nibName: "NKIndexCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 64
        header.backgroundColor = NKBlueColor()
        tableView.backgroundColor = UIColor.clearColor()
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
        watingLabel.animate(from: 0, to: Int(NKLibraryAPI.sharedInstance.getWatingInterest()))
        investLabel.animate(from: 0, to: NKLibraryAPI.sharedInstance.getSumInvest())
        weightRateLabel.animate(from: 0, to:Int( NKLibraryAPI.sharedInstance.getWeightRate() * 100))
        
    }
 
    @IBAction func showPieStatics(sender: AnyObject) {
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "indexToRecord" {
            let recordVc = segue.destinationViewController as! NKRecordController
            
            recordVc.dataSource = selectedPlatform
        }
        
    }
    
    private func configureHeader() {
        investLabel.textColor = UIColor.flatWhiteColor()
        passedInterestLabel.textColor = UIColor.flatWhiteColor()
        watingLabel.textColor = UIColor.flatWhiteColor()
        weightRateLabel.textColor = UIColor.flatWhiteColor()
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
        cell.numberLabel.text = plat.numbersOfAccounts()
        return cell
    }
    
   
    
}

extension NKIndexController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return NKIndexSectionHeader.indexSectionHeader()
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedPlatform = platforms[indexPath.row]
        performSegueWithIdentifier("indexToRecord", sender: nil)
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
